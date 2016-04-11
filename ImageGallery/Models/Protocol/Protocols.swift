//
//  Protocols.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

protocol AlbumDelegate : class {
    

    func albumSelected(item:AnyObject!)->Void
    
}

protocol MenuDelegate : class {
    func menuSelected(selectedMenu:[String:String])->Void
}

