//
//  UIScrollView+Custom.swift
//  ImageGallery
//
//  Created by Suresh on 4/10/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView : UIScrollViewDelegate {
    
//    public func reloadTableOrCollectionView(objects:[AnyObject]!)->Void
    
    
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        if(self.contentOffset.y + 100 >= self.contentSize.height - self.bounds.size.height) {
            if(DataManager.sharedDataManager().isRequiredLoadNextPage == false ) {
                DataManager.sharedDataManager().isRequiredLoadNextPage = true
                DataManager.sharedDataManager().currentPage += 1
                self.fetchAlbums()
            }
        }
    }
    
    func fetchAlbums() {
        let sharedInstance = DataManager.sharedDataManager()
        NetworkManager.fetchAlbums(sharedInstance.currentAlbumCategory, isViral: sharedInstance.isViral, pageNumber: sharedInstance.currentPage,  handler:{
            (objects:[AnyObject]!) -> Void in
            self.reloadTableOrCollectionView(objects)
            sharedInstance.isRequiredLoadNextPage = false
        })
    
    }
    
    
    func reloadTableOrCollectionView(objects: [AnyObject]!) {
        //Does nothing...
        //This Super class implementaion can be replaced with SubClass call.
    }
    
}