//
//  GalleryTableView.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class GalleryTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    
    //local object
    var imagesInfoArray : [AnyObject] = []
    
    //Delegate to pass data
    static var albumDelegate : AlbumDelegate!
   
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.backgroundColor = kBLACK_COLOR
    }

    required init?(coder aDecoder: NSCoder) {
       
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = kBLACK_COLOR
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imagesInfoArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("GalleryTableViewCell") as? GalleryTableViewCell
        if cell == nil {
            tableView.registerNib(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
            cell = tableView.dequeueReusableCellWithIdentifier("GalleryTableViewCell") as?GalleryTableViewCell
        }
        
    
        let object = self.imagesInfoArray[indexPath.row]
        let coverImage = object.coverImage() as IMGImage
        var url : NSURL!
        url = coverImage.URLWithSize(IMGSize.SmallThumbnailSize) as NSURL
        cell?.albumTitleLabel.text = object.valueForKey("title") as? String
        cell?.albumImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder2"), options: SDWebImageOptions.CacheMemoryOnly)
        cell?.albumUpsLabel.text = SYMBOL_UP_ARROW+"\(object.ups)"
        cell?.albumDownsLabel.text = SYMBOL_DOWN_ARROW+"\(object.downs)"
        return cell!

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return 110
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = self.imagesInfoArray[indexPath.row]
        GalleryCollectionView.albumDelegate.albumSelected(object)
        
    }
    
     //MARK: - SUPERCLASS's method overriden
    override func reloadTableOrCollectionView(objects: [AnyObject]!) {
        self.imagesInfoArray += objects
        self.reloadData()
    }
}
