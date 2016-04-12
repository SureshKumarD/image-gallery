//
//  LoginViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

     @IBOutlet weak var loginBannerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.title = "Login..."
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = kWHITE_COLOR
        self.navigationController?.navigationBar.translucent = false
        
        //This first hit is to get authentication
        self.proceedLogin()

    }
    
    func styling() {
        self.loginBannerView.backgroundColor = kWHITE_COLOR
        self.loginBannerView.alpha = 0.25;
    }
   
    @IBAction func proceedLoginTapped(sender: AnyObject) {
        self.proceedLogin()
    }
    
    //Does authentication...
    func proceedLogin() {
        DataManager.sharedDataManager().startActivityIndicator()
        NetworkManager.getHotImageGallery(0, sortViral: true, completionHandler: { _ in})
       
    }
}
