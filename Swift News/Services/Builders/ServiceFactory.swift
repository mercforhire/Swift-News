//
//  ServiceFactory.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

/*
 A class that help us fetch some data from the internet and converts the data to defined Model objects is considered a 'service'.
 
 This ServiceFactory is the common place where all these services are stored. We expect a production app to have numerous different API services. This class also does all the tedious initialization work for every service IE: setting up any dependencies.
 */
class ServiceFactory {
    private let configurationManager = ConfigurationManager()
    private let httpOperationsManager = HttpOperationsManager()
    
    lazy var feedService: FeedService = FeedServiceImpl(configurationManager: configurationManager, httpOperationsManager: httpOperationsManager)
}
