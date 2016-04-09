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
        self.proceedLogin()

    }
    
    func styling() {
        self.loginBannerView.backgroundColor = UIColor.whiteColor()
        self.loginBannerView.alpha = 0.25;
    }
   
    @IBAction func proceedLoginTapped(sender: AnyObject) {
        self.proceedLogin()
    }
    
    func proceedLogin() {
        DataManager.sharedDataManager().startActivityIndicator()
        NetworkManager.sharedNetworkManager().getHotImageGallery(0, sortViral: true, completionHandler: {})
    }
}
