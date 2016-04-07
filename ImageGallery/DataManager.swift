//
//  DataManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit


var dataManager = DataManager()

class DataManager: NSObject {
    var galleryImages : [AnyObject]!
    var activityIndicator : UIActivityIndicatorView?
    override init() {
        
        
    }
    class func sharedDataManager()-> DataManager! {
        dataManager = DataManager()
        return dataManager
    }
    
    func startActivityIndicator() {
        if(self.activityIndicator == nil){
            self.activityIndicator  = UIActivityIndicatorView()
            self.activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            self.activityIndicator?.frame = CGRectMake(WIDTH_WINDOW_FRAME/2 - 50, HEIGHT_WINDOW_FRAME/2-50, 100, 100)
        }
        
       
        let mainWindow = UIApplication.sharedApplication().keyWindow
        mainWindow?.addSubview(self.activityIndicator!)
        
        self.activityIndicator?.startAnimating()
    }
    
    func stopActivityIndicator() {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
    }
    
}
