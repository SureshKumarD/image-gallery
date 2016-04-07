//
//  Constants.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

let APP_DELEGATE_INSTANCE = UIApplication.sharedApplication().delegate as? AppDelegate

let BASE_URL  = "https://api.imgur.com/"
let API_VERSION = "3"
let APP_ID = "ab7f22263dcb969"

let WIDTH_WINDOW_FRAME =  UIScreen.mainScreen().bounds.size.width
let HEIGHT_WINDOW_FRAME =  UIScreen.mainScreen().bounds.size.height

enum ServerRequestType: Int {
    case Get = 0, POST, PUT, DELETE
}

