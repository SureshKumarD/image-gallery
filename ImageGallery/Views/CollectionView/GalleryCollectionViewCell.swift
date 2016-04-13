//
//  GalleryCollectionViewCell.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    @IBOutlet weak var albumUpsLabel: UILabel!
    @IBOutlet weak var albumDownsLabel: UILabel!
    
    @IBOutlet weak var albumImagesLabel: UILabel!
    @IBOutlet weak var albumTitleLabelHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.contentView.backgroundColor = UIColor.clearColor()
//        self.numberFormatter.usesGroupingSeparator = true
//        self.numberFormatter.groupingSeparator = NSLocale.currentLocale().objectForKey(NSLocaleGroupingSeparator) as! String!
        
      
    }
    
    
}
