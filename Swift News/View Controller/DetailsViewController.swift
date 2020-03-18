//
//  DetailsViewController.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: BaseViewController {
    var thumbnailUrl: URL?
    var webUrl: URL!
    
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
        if let thumbnailUrl = thumbnailUrl {
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
        let request = URLRequest(url: webUrl)
        webView.load(request)
    }
}
