//
//  FeedServiceImpl.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

// Implementation Service used to fetch the ExchangeRates from the server or cache
class FeedServiceImpl: FeedService {
    private let kFetchFeedURL: String = "r/swift/.json"
    
    // Dependencies:
    private let configurationManager: ConfigurationManager
    private let httpOperationsManager: HttpOperationsManager
    
    required init(configurationManager: ConfigurationManager, httpOperationsManager: HttpOperationsManager) {
        self.configurationManager = configurationManager
        self.httpOperationsManager = httpOperationsManager
    }
    
    func fetchFeed(completion: @escaping (Result<Listing, Error>) -> Void) {
        let url: String = String(format: "%@%@", configurationManager.apiServerBaseURL(), kFetchFeedURL)
        httpOperationsManager.performGetRequest(urlString: url) { result in
            switch result {
            case .success(let data):
                do {
                    let listing: Listing = try JSONDecoder().decode(Listing.self, from: data)
                    completion(.success(listing))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
