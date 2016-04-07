//
//  AppDelegate.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, IMGSessionDelegate{

    var window: UIWindow?
    var dataObject : DataManager!
    public var networkObject : NetworkManager!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Singleton classes to handle network related and data related functionalities.
        self.instantiateCommonObjects()
        IMGSession.authenticatedSessionWithClientID(CLIENT_ID, secret: SECRET_KEY, authType: IMGAuthType.CodeAuth, withDelegate:self)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        let params = NSMutableDictionary()
        
        for param in (url.query?.componentsSeparatedByString("&"))! {
            let elements = NSArray(array: param.componentsSeparatedByString("="))
            if(elements.count < 2) {
                continue
            }
            params .setObject(elements[1], forKey: elements[0] as! String)
            
        }
        let pinCode : String = params["code"] as! String
        
        if(pinCode.isEmpty) {
            let alertView = UIAlertView(title: "Error", message: "Access was denied by Imgur", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            APP_DELEGATE_INSTANCE?.dataObject.startActivityIndicator()
            return false;
        }
        IMGSession.sharedInstance().authenticateWithCode(pinCode)
        
        self.networkObject.fetchDefaultImageGallery({
            APP_DELEGATE_INSTANCE?.dataObject.stopActivityIndicator()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController")
            let navController = self.window?.rootViewController as! UINavigationController
            
            navController.pushViewController(homeVC, animated: false)
        })
        
        return true

        

    }
    func instantiateCommonObjects() {
        
        self.dataObject      = DataManager.sharedDataManager()
        self.networkObject   = NetworkManager.sharedNetworkManager()
        
    }
    
    
    
    //MARK:- IMGSessionDelegate
    func imgurSessionNeedsExternalWebview(url: NSURL!, completion: (() -> Void)!) {
        UIApplication.sharedApplication().openURL(url)
    }
   

}

