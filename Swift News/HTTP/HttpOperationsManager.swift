//
//  HttpOperationsManager.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

enum HttpOperationsManagerError: Error {
    case invalidData
}

/**
 The HTTP Operations manager perform all http requests
 */
class HttpOperationsManager {
    let session : URLSession
    
    init() {
        // Limit to just a single concurrent network operation
        let configuration : URLSessionConfiguration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 2
        session = URLSession(configuration: configuration)
    }
    
    /**
     Used to perform a HTTP GET request
     */
    func performGetRequest(urlString: String, headers: NSDictionary = [:], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url : URL = URL(string: urlString) else { return }
        
        // Set up a URLRequest for the GET Request with an 'Authorization' Header
        var getRequest : URLRequest = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        
        // Add the headers
        headers.enumerateKeysAndObjects { (key, obj, stop) in
            getRequest.addValue(obj as! String, forHTTPHeaderField: key as! String)
        }
        
        //Set the HTTP request type to GET
        getRequest.httpMethod = "GET"
        
        //Execute the network call
        let getTask: URLSessionDataTask = session.dataTask(with: getRequest) { (data, response, error) in
            //Network call complete
            DispatchQueue.main.async(execute: {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse : HTTPURLResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200, let data = data {
                        completion(.success(data))
                    } else {
                        completion(.failure(NSError(domain: Bundle.main.bundleIdentifier!, code: 400, userInfo: nil)))
                    }
                }
            })
        }
        getTask.resume()
    }
    
    func download(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(HttpOperationsManagerError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
