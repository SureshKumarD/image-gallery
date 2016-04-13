//
//  GalleryCollectionView.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit


public class GalleryCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    //local object
    public var imagesInfoArray : [AnyObject] = []
    
    //Delegate to pass data
    static var albumDelegate : AlbumDelegate!
    
    //Number Formatter - (comma , )separated numbers...
    let numberFormatter = NSNumberFormatter()

    var viewOption : GalleryView!
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.imagesInfoArray = []
        self.viewOption = GalleryView.Staggered
        self.numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CollectionView Datasources
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return NUMBER_ONE
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesInfoArray.count
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        let object = self.imagesInfoArray[indexPath.row]
        let coverImage = object.coverImage() as IMGImage
        var url : NSURL!
        if(self.viewOption == GalleryView.Grid) {
            url = coverImage.URLWithSize(IMGSize.LargeThumbnailSize) as NSURL
        }else {
            url = coverImage.URLWithSize(IMGSize.BigSquareSize) as NSURL
        }
        //Album title
        cell.albumTitleLabel.text = object.valueForKey("title") as? String
        
        //Album Cover Image
        cell.albumImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder2"), options: SDWebImageOptions.CacheMemoryOnly)

        //Up votes
        var tempString = self.numberFormatter.stringFromNumber(NSNumber(integer:object.ups as NSInteger!))!
        cell.albumUpsLabel.text = SYMBOL_UP_ARROW + tempString
        
        //Down votes
        tempString = self.numberFormatter.stringFromNumber(NSNumber(integer:object.downs as NSInteger!))!
        cell.albumDownsLabel.text = SYMBOL_DOWN_ARROW + tempString
        
        //Number of images
        cell.albumImagesLabel.text = "\(object.imagesCount)"
        
        return cell
    }

    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
       return UICollectionReusableView()
    }
   
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(self.viewOption == GalleryView.Grid) {
            return CGSizeMake(WIDTH_WINDOW_FRAME - 20, WIDTH_WINDOW_FRAME - 100)
        }else {
            return CGSizeMake((WIDTH_WINDOW_FRAME/2) - 2.5, WIDTH_WINDOW_FRAME/2 + 50)
        }
    }
    
    //MARK:- CollectionView Delegates
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object = self.imagesInfoArray[indexPath.row]
        GalleryCollectionView.albumDelegate.albumSelected(object)
        
    }
    
    //MARK: - SUPERCLASS's method overriden
    override func reloadTableOrCollectionView(objects: [AnyObject]!) {
        self.imagesInfoArray += objects
        self.reloadData()
    }
    

}
