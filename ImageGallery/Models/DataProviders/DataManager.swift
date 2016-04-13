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
    
    //SharedInstance...
    static let dataManager = DataManager()
    
    //Activity Indicator...
    var activityIndicator : UIActivityIndicatorView?
    
    //Global vars required for server hit...
    var isViral : Bool
    var currentAlbumCategory : AlbumGategory
    var currentPage : Int
    var isRequiredLoadNextPage : Bool
    
    
    override init() {
        
        //Initialize all data members...
        self.isViral = true
        self.currentAlbumCategory = AlbumGategory.Hot
        self.currentPage = 0
        self.isRequiredLoadNextPage = false
    }
    
    
    
    class func sharedDataManager()-> DataManager! {
        return dataManager
    }
    
    
    //MARK: - Acitivity Indicator - usage
    func startActivityIndicator() {
        
        if(self.activityIndicator == nil){
            self.activityIndicator  = UIActivityIndicatorView()
            
        }
        self.activityIndicator?.frame = CGRectMake(WIDTH_WINDOW_FRAME/2 - 50, HEIGHT_WINDOW_FRAME/2-50, 100, 100)
        self.activityIndicator?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        
        let mainWindow = UIApplication.sharedApplication().keyWindow
        mainWindow?.addSubview(self.activityIndicator!)
        
        self.activityIndicator?.startAnimating()
    }
    
    
    func stopActivityIndicator() {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
    }
    
}
