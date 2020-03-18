//
//  FeedData.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

struct FeedData: Codable {
    var dist: Int
    var children: [FeedChild]
}
