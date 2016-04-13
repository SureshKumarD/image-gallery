//
//  UIAlertView+Custom.swift
//  ImageGallery
//
//  Created by Suresh on 4/13/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertView  {
    public func closAlertAfterDelay(delayInSeconds : NSTimeInterval) {
        self.performSelector(Selector("closeAlertView"), withObject: nil, afterDelay: delayInSeconds)
       
    }
    
    func closeAlertView() {
        self.dismissWithClickedButtonIndex(0, animated: true)
    }

}