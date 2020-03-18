//
//  FeedItemTableViewCell.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var thumbnailView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageContainer.isHidden = true
        titleLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(title: String, thumbnailUrl: String?) {
        titleLabel.text = title
        
        if let thumbnailUrl = thumbnailUrl, 
            thumbnailUrl.starts(with: "http"),
            let thumbnail = URL(string: thumbnailUrl) {
            
            self.imageContainer.isHidden = false
            
            UIImage.asyncFrom(url: thumbnail) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    self.thumbnailView.image = image
                case .failure:
                    self.imageContainer.isHidden = true
                }
            }
        } else {
            imageContainer.isHidden = true
        }
    }
}
