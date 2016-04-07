//
//  LoginViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.proceedLogin()

    }
    @IBAction func proceedLoginTapped(sender: AnyObject) {
        self.proceedLogin()
    }
    
    func proceedLogin() {
        APP_DELEGATE_INSTANCE?.dataObject.startActivityIndicator()
        APP_DELEGATE_INSTANCE?.networkObject.fetchDefaultImageGallery({})
    }
}
