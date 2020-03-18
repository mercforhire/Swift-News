//
//  ConfigurationManager.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

/**
 This class is used to gain access to values stored in environments.plist
 */
class ConfigurationManager {
    private let kEnvironmentsPlistFileName : String = "environments"
    private let kBaseAPIUrlKey : String = "api_base_url"
    private let environmentSettings : NSDictionary

    init() {
        environmentSettings = NSDictionary(contentsOfFile: Bundle.main.path(forResource: kEnvironmentsPlistFileName, ofType: "plist")!)!
    }
    
    /**
     Get base server URL
     */
    func apiServerBaseURL() -> String {
        return environmentSettings[kBaseAPIUrlKey] as! String
    }
}
