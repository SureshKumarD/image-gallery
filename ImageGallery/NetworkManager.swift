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
class NetworkManager: NSObject {
    var sessionManager : AFHTTPSessionManager!
    override init() {
        
    }
    class func sharedNetworkManager()-> NetworkManager! {
        networkManager = NetworkManager()
        return networkManager
    }
    
    
    public func requestServer(urlString:String!, type : ServerRequestType, completionHandler:  (result :AnyObject, error: NSError) -> Void) -> Void  {
        
        
        
        self.sessionManager  = AFHTTPSessionManager(baseURL: NSURL(string: BASE_URL))
//        self.sessionManager.requestSerializer = AFJSONRequestSerializer()
        self.sessionManager.requestSerializer.setValue(APP_ID, forHTTPHeaderField: "Authorization")
        self.sessionManager.responseSerializer = AFJSONResponseSerializer()
        
        self.sessionManager.GET(urlString, parameters: nil, success: {
            (task: NSURLSessionDataTask!, responseObject: AnyObject?) in
            print("success")
            let error : NSError? = nil;
            completionHandler(result: responseObject!, error:error! )
            }, failure: {
                (task: NSURLSessionDataTask?, error: NSError) in
                print("error")
        })
        

        
    }
    
    func setAuthentication (request: NSMutableURLRequest) -> NSMutableURLRequest! {
        
        request.setValue(APP_ID, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func constructURL(urlString: String!)->String! {
        
        return (BASE_URL+"/"+API_VERSION+"/"+urlString)
        
    }
    
}
