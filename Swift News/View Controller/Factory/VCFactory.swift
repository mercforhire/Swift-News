//
//  VCFactory.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import Foundation
import UIKit

/*
 Purpose of this class is to be the central point for creating all VCs and hides any logic involved in the initialization
 of the view controllers for easy usage
 */
class VCFactory {
    let feedService: FeedService
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    private func initBaseVC(baseVC: BaseViewController) {
        baseVC.vcFactory = self
    }
    
    func createMainViewController() -> MainViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        initBaseVC(baseVC: vc)
        vc.feedService = feedService
        return vc
    }
    
    func createDetailsViewController(title: String, thumbnailUrl: URL? = nil, webUrl: URL) -> DetailsViewController {
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        initBaseVC(baseVC: vc)
        vc.title = title
        vc.thumbnailUrl = thumbnailUrl
        vc.webUrl = webUrl
        return vc
    }
}
