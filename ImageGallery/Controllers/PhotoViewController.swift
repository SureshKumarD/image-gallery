//
//  PhotoViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/14/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class PhotoViewController: BaseViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    //Image url string...
    var imageUrl : String!
    
    //Navigation...
    var navigationRightButton : UIButton!
    var rightBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializations()
        self.setNavigationRightButton()
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- METHODS
    func initializations() {
        self.scrollView.delegate = self
        self.selectedImageView.contentMode = UIViewContentMode.Redraw
        self.selectedImageView.sd_setImageWithURL(NSURL(string: self.imageUrl), placeholderImage: UIImage(named: "placeholder2"), options: SDWebImageOptions.CacheMemoryOnly)
        self.rightBarButtonItem = UIBarButtonItem()
        self.title = "Image"
    }
    
    override func didFinishLayout() {
        self.selectedImageView.frame = self.view.bounds
        self.selectedImageView.contentMode = .Center
    }
    
    
    //MARK:- Zooming action
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.selectedImageView
    }
    
    
    //MARK:- Close Button
    func setNavigationRightButton() {
        if(self.navigationRightButton == nil) {
            self.navigationRightButton = UIButton(type: UIButtonType.System)
        }
        self.navigationRightButton.frame = CGRectMake(0, 0, 50, 50)
        self.navigationRightButton.imageEdgeInsets = UIEdgeInsetsMake(15,15,15,15)
        self.navigationRightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        self.navigationRightButton.tintColor = kWHITE_COLOR
        self.navigationRightButton.imageView?.contentMode = UIViewContentMode.Center
        let image = UIImage(named: "Close")
        let newImage = image?.imageWithRenderingMode(.AlwaysTemplate) as UIImage!
        
        self.navigationRightButton.setImage(newImage, forState: .Normal)
        self.navigationRightButton.tintColor = kWHITE_COLOR

        self.navigationRightButton.addTarget(self, action: Selector("dismissCurrentViewController"), forControlEvents: UIControlEvents.TouchUpInside)
        self.rightBarButtonItem.customView = self.navigationRightButton
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        
        
    }
    
    func dismissCurrentViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK:- Close button action

}
