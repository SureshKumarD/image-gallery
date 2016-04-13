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
let kGRAY_COLOR = UIColor(red: 102/255, green: 102/255, blue: 108/255, alpha: 1.0)
let kWHITE_COLOR = UIColor.whiteColor()
let kSUB_TEXT_COLOR = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1.0)

//Border..
let kTILE_BORDER = 5.0

//Configuration Constants...
let URL_BASE  = "https://api.imgur.com"
let API_VERSION = "3"
let URL_FRAGMENT_ALBUM = "album"
let CLIENT_ID = "ab7f22263dcb969"
let SECRET_KEY = "b2c92fc39d76006783333701b70e9b02ae9ae0b4"

//Other Constants...
let NUMBER_ZERO = 0
let NUMBER_ONE = 1
let NUMBER_TWO = 2
let NUMBER_THREE = 3
let NUMBER_FOUR = 4
let NUMBER_FIVE = 5

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

enum AlbumGategory: Int {
    case Hot = 0, Top, User
}
