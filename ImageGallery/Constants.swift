//
//  Constants.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

let APP_DELEGATE_INSTANCE = UIApplication.sharedApplication().delegate as? AppDelegate


//Colors...
let kBLACK_COLOR = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
let kWHITE_COLOR = UIColor.whiteColor()

//Border..
let kTILE_BORDER = 5.0

let BASE_URL  = "https://api.imgur.com/"
let API_VERSION = "3"
let CLIENT_ID = "ab7f22263dcb969"
let SECRET_KEY = "b2c92fc39d76006783333701b70e9b02ae9ae0b4"
let WIDTH_WINDOW_FRAME =  UIScreen.mainScreen().bounds.size.width
let HEIGHT_WINDOW_FRAME =  UIScreen.mainScreen().bounds.size.height

let SYMBOL_UP_ARROW = "\u{21E7}"
let SYMBOL_DOWN_ARROW = "\u{21E9}"
enum ServerRequestType: Int {
    case Get = 0, Post, Put, Delete
}

enum GalleryView: Int {
    case Staggered = 0, List, Grid
}
