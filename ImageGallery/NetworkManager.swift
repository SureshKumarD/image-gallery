//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    

    //MARK:- Get Image Gallery from sections Hot, Top, User...
    
    class func getHotImageGallery(page : Int, sortViral: Bool, completionHandler:()->Void) {
        IMGGalleryRequest.hotGalleryPage(page, withViralSort: sortViral, success: { (objects :[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error: NSError!) -> Void in
                
        }
    }
    
        
    class func getTopImageGallery(page : Int, sortViral : Bool, completionHandler:()->Void) {
        
        IMGGalleryRequest.topGalleryPage(page, withWindow:IMGTopGalleryWindow.All , withViralSort: true, success: { (objects :[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error : NSError!) -> Void in
                
        }
       
                    
    }
    
        
    class func getuserImageGallery(page : Int,  sortViral : Bool, completionHandler:()->Void) {
        
        IMGGalleryRequest.userGalleryPage(page, withViralSort: true, showViral: true, success: { (objects:[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error :NSError!) -> Void in
                
        }
        
                    
    }
    
    
    class func filterAlbums(objects :[AnyObject!]) {
        for object in objects {
            if(object.isKindOfClass(IMGGalleryAlbum)) {
                DataManager.sharedDataManager().objects.append(object)
            }
        }
    }
    

    
    //MARK: - Custom Server Call
    // Fetch album images from the imgur server using album id
    class func getAlbumImages(urlString : String, success: ([String : AnyObject]?)-> Void, failure :( NSError)->Void) {
        
        let manager = AFHTTPSessionManager(baseURL: NSURL(string:URL_BASE))
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer.setValue("Client-Id "+CLIENT_ID, forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("access-control-allow-headers", forHTTPHeaderField: "Content-Type")
        manager.responseSerializer.set("X-RateLimit-ClientLimit, X-RateLimit-ClientRemaining, X-RateLimit-UserLimit, X-RateLimit-UserRemaining, X-RateLimit-UserReset", forHTTPHeaderField: "Access-Control-Expose-Headers")
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json", "text/json", "text/javascript", "text/html","text/xml"]) as? Set<String>
        manager.requestSerializer.HTTPRequestHeaders
//        let request = NSMutableURLRequest(URL: NSURL(string:URL_BASE+urlString)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100000)
//        request.HTTPMethod = "GET"
//        request.setValue("Client-Id "+CLIENT_ID, forHTTPHeaderField: "Authorization")
//        manager.dataTaskWithRequest(request) { (response :NSURLResponse, responseObjec : AnyObject?, error: NSError?) -> Void in
//            print(response )
//        }
//        
        


        manager.GET(urlString, parameters: nil, progress: nil, success: {
            (task: NSURLSessionDataTask!, responseObject: AnyObject?) in
           
                let response = responseObject as! Dictionary<String, AnyObject>
                 success(response)
            
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                print("error")
                failure( error)
        })
        
    }
    
    
            
    

    
}
