//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

//let BASE_URL  = "https://api.imgur.com/"
//let API_VERSION = "3"
//let APP_ID = "ab7f22263dcb969"


var networkManager = NetworkManager()
public class NetworkManager: NSObject {
//    var sessionManager : AFHTTPSessionManager!
    var objects : Array<AnyObject>
    override init() {
        self.objects = []
    }
    class func sharedNetworkManager()-> NetworkManager! {
        networkManager = NetworkManager()
        return networkManager
    }
    
    
    func fetchDefaultImageGallery(completionHandler:()->Void) {
    
        IMGGalleryRequest.hotGalleryPage(0, success: { (objects: [AnyObject]!) -> Void in
            APP_DELEGATE_INSTANCE?.dataObject.galleryImages = objects as [AnyObject]
            self.objects = objects
            completionHandler()
        }) { (error : NSError!) -> Void in
    
    }
    

    }
    func setAuthentication (request: NSMutableURLRequest) -> NSMutableURLRequest! {
        
        request.setValue(CLIENT_ID, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func constructURL(urlString: String!)->String! {
        
        return (BASE_URL+"/"+API_VERSION+"/"+urlString)
        
    }
    
}
