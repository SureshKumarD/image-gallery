//
//  GalleryTableViewCell.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!

    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumUpsLabel: UILabel!
    @IBOutlet weak var albumDownsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 5.0
        self.containerView.layer.borderColor = UIColor.grayColor().CGColor
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
