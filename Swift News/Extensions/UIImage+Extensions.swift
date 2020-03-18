//
//  UIImage+Extensions.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit

enum UIImageError: Error {
    case invalidData
}

extension UIImage {
    /// Loads an UIImage from internet asynchronously
    static func asyncFrom(url: URL, service: HttpOperationsManager = HttpOperationsManager(), completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        service.download(url: url) { result in
            switch result {
            case .success(let data):
                asyncFrom(data: data, completion: completion)
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    private static func asyncFrom(data: Data, completion: @escaping (Result<UIImage, Error>) -> Void) {
        DispatchQueue.global(qos: .default).async {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(UIImageError.invalidData))
                }
            }
        }
    }
}
