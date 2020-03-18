//
//  FeedItem.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation

struct FeedItem: Codable {
    let url: String
    let title: String
    let thumbnail: String
    let thumbnailHeight: Double?
    let thumbnailWidth: Double?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case title = "title"
        case thumbnail = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }
}

