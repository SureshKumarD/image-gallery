//
//  DataManager.swift
//  ImageGallery
//
//  Created by Suresh on 4/6/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit


var dataManager = DataManager()
class DataManager: NSObject {
    override init() {
        
    }
    class func sharedDataManager()-> DataManager! {
        dataManager = DataManager()
        return dataManager
    }
    
}
