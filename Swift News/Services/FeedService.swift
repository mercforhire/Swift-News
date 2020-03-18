//
//  FeedService.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

/**
 Definition of the service used to fetch the the feed data
 */
protocol FeedService {
    init(configurationManager: ConfigurationManager, httpOperationsManager: HttpOperationsManager)
    
    func fetchFeed(completion: @escaping (Result<Listing, Error>) -> Void)
}
