//
//  DetailsViewController.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit
import WebKit

// Once we can scroll a list of articles, we will want a way to display the full article in a new view. In the
// case the article contains a thumbnail image, we'd like to show that image at the top of the article and
// article body. If no thumbnail, just article body. There should also be a way to return to the 'main' view.
// The navigation bar title should contain the article title.

class DetailsViewController: BaseViewController {
    var feedItem: FeedItem!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    
    func setupUI() {
        self.thumbnailImageView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadContents()
    }
    
    private func loadContents() {
        // load thumbnail if exists
        if let thumbnailUrl = URL(string: feedItem.thumbnail)  {
            UIImage.asyncFrom(url: thumbnailUrl, completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    self.thumbnailImageView.image = image
                    self.thumbnailImageView.isHidden = false
                case .failure:
                    self.thumbnailImageView.isHidden = true
                }
            })
            
        } else {
            thumbnailImageView.isHidden = true
        }
        
        // load actual content
        if let webUrl = URL(string: feedItem.url)  {
            let request = URLRequest(url: webUrl)
            webView.load(request)
        }
    }
}
