//
//  NetworkManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit


var networkManager = NetworkManager()
public class NetworkManager: NSObject {
    
    var objects : Array<AnyObject>
    override init() {
        self.objects = []
    }
    class func sharedNetworkManager()-> NetworkManager! {
        networkManager = NetworkManager()
        return networkManager
    }
    
    
    func getAlbumWithId(albumID :String!, isWithCoverImage: Bool, completionHandler:()->Void) {

        IMGGalleryRequest.albumWithID(albumID, withCoverImage:isWithCoverImage , success:{(album : IMGGalleryAlbum!) -> Void in
            print(album)
            }){(error: NSError!) -> Void in
        }
        
    }


    //MARK:- Get Image Gallery from sections Hot, Top, User...
    
    func getHotImageGallery(page : Int, sortViral: Bool, completionHandler:()->Void) {
        IMGGalleryRequest.hotGalleryPage(page, withViralSort: sortViral, success: { (objects :[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error: NSError!) -> Void in
                
        }
    }
    
        
    func getTopImageGallery(page : Int, sortViral : Bool, completionHandler:()->Void) {
        
        IMGGalleryRequest.topGalleryPage(page, withWindow:IMGTopGalleryWindow.All , withViralSort: true, success: { (objects :[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error : NSError!) -> Void in
                
        }
       
                    
    }
    
        
    func getuserImageGallery(page : Int,  sortViral : Bool, completionHandler:()->Void) {
        
        IMGGalleryRequest.userGalleryPage(page, withViralSort: true, showViral: true, success: { (objects:[AnyObject]!) -> Void in
            self.filterAlbums(objects)
            completionHandler()
            }) { (error :NSError!) -> Void in
                
        }
        
                    
    }
    
    
    func filterAlbums(objects :[AnyObject!]) {
        for object in objects {
            if(object.isKindOfClass(IMGGalleryAlbum)) {
                self.objects.append(object)
            }
        }
    }
    


    
}
