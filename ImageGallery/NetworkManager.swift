//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    

    //MARK:- Get Hot Image Gallery
    
    class func getHotImageGallery(page : Int, sortViral: Bool, completionHandler:(objects :[AnyObject]!)->Void) {
        IMGGalleryRequest.hotGalleryPage(page, withViralSort: sortViral, success: { (objects :[AnyObject]!) -> Void in
            let albums = self.filterAlbums(objects)
            completionHandler(objects: albums)
            }) { (error: NSError!) -> Void in
                
        }
    }
    
    
    //MARK:- Get Top Image Gallery
    
    class func getTopImageGallery(page : Int, sortViral : Bool, completionHandler:(objects :[AnyObject]!)->Void) {
        
        IMGGalleryRequest.topGalleryPage(page, withWindow:IMGTopGalleryWindow.All , withViralSort: sortViral, success: { (objects :[AnyObject]!) -> Void in
            let albums = self.filterAlbums(objects)
            completionHandler(objects: albums)
            }) { (error : NSError!) -> Void in
                
        }
       
                    
    }
    
    
    //MARK:- Get User Image Gallery
        
    class func getuserImageGallery(page : Int,  sortViral : Bool, completionHandler:(objects :[AnyObject]!)->Void) {
        
        IMGGalleryRequest.userGalleryPage(page, withViralSort: sortViral, showViral: false, success: { (objects:[AnyObject]!) -> Void in
            let albums = self.filterAlbums(objects)
            completionHandler(objects: albums)
            }) { (error :NSError!) -> Void in
                
        }
        
                    
    }
    
    
    //MARK:- Filter only Albums
    
    class func filterAlbums(objects :[AnyObject!]) -> [AnyObject]! {
        var albums :[AnyObject] = []
        for object in objects {
            if(object.isKindOfClass(IMGGalleryAlbum)) {
                albums.append(object)
            }
        }
        return albums
        
    }
    

    //Servercall distribution amount Hot, Top and User albums...
    
    class func fetchAlbums(category : AlbumGategory, isViral : Bool, pageNumber : Int, handler:(objects :[AnyObject]!)->Void) {

        switch(category) {
        case .Hot:
            NetworkManager.getTopImageGallery(pageNumber, sortViral: isViral, completionHandler:{
                (objects:[AnyObject]!) -> Void in
                handler(objects: objects)
                })
            break
        case .Top:
            NetworkManager.getTopImageGallery(pageNumber, sortViral: isViral,  completionHandler:{
                (objects:[AnyObject]!) -> Void in
                handler(objects: objects)
            })
            break
        case .User:
            NetworkManager.getuserImageGallery(pageNumber, sortViral: isViral,  completionHandler:{
                (objects:[AnyObject]!) -> Void in
                handler(objects: objects)
            })
            break
        }
    }
    
    //MARK: - Custom Server Call
    // Fetch album images from the imgur server using album id
    class func getAlbumImages(urlString : String, success: ([String : AnyObject]?)-> Void, failure :( NSError)->Void) {
        
        let manager = AFHTTPSessionManager(baseURL: NSURL(string:URL_BASE))
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer.setValue("Client-Id "+CLIENT_ID, forHTTPHeaderField: "Authorization")
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain","application/json", "text/json", "text/javascript", "text/html","text/xml"]) as? Set<String>
        manager.requestSerializer.HTTPRequestHeaders
    
        
        manager.GET(urlString, parameters: nil, progress: nil, success: {
            (task: NSURLSessionDataTask!, responseObject: AnyObject?) in
           
            let response = responseObject?["data"] as! Dictionary<String, AnyObject>
                success(response)
            
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                print("error")
                failure( error)
        })
        
    }
    
    
            
    

    
}
