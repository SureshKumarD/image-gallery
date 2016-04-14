//
//  AlbumImageCell.swift
//  ImageGallery
//
//  Created by Suresh on 4/14/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class AlbumImageCell: UITableViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    override func awakeFromNib() {
        self.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
        
        //        self.frame = CGRectMake(20.0, 20.0, 50.0, 50.0);
        self.backgroundColor = kWHITE_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyle.None;
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//            
////        self.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
////        self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
////        self.frame = CGRectMake(20.0, 20.0, 50.0, 50.0);
//        self.backgroundColor = kWHITE_COLOR;
//        self.selectionStyle = UITableViewCellSelectionStyle.None;
//        
//    }

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        //        self.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
//        self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//        //        self.frame = CGRectMake(20.0, 20.0, 50.0, 50.0);
//        self.backgroundColor = kWHITE_COLOR;
//        self.selectionStyle = UITableViewCellSelectionStyle.None;
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
}
