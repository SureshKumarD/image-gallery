//
//  DetailViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {

    @IBOutlet var carousel : iCarousel!
    var imagesArray  = []
    var progress = NSProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carousel.type = .Linear
        self.carousel.dataSource = self
        self.carousel.delegate = self
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
        self.preloadAlbumImages()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- METHODS
    //MARK:- Gradient Background
    func setGradientBackground() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [kWHITE_COLOR.CGColor, UIColor.blackColor().CGColor]
        self.view.layer.insertSublayer(gradient, atIndex: 0)
    }

    //MARK:- Carousel Implementation
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return self.imagesArray.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {

        var itemView: UIImageView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:200, height:200))
            itemView.contentMode = .Center
            let imageObject = self.imagesArray[index] as! [String: AnyObject]
            let url = imageObject["link"]as! String
            itemView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "placeholder2"), options: SDWebImageOptions.CacheMemoryOnly)
            itemView.contentMode = UIViewContentMode.ScaleToFill
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! UIImageView;
        }
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.1
        }
        return value
    }
    
    
    //Preload images
    func preloadAlbumImages() {
        DataManager.sharedDataManager().startActivityIndicator()
        self.carousel.hidden = true
        var imageUrlsArray :[AnyObject]! = []
        for image in self.imagesArray {
            imageUrlsArray.append(image["link"]as! String)

        }
        
        
        SDWebImagePrefetcher.sharedImagePrefetcher().prefetchURLs(imageUrlsArray, progress: { (int1 : UInt, int2 : UInt) -> Void in
            self.carousel.hidden = false
            
            
            }) { (int1 : UInt, int2 :UInt) -> Void in
                self.carousel.hidden = false
                self.carousel.reloadData()
                DataManager.sharedDataManager().stopActivityIndicator()
                self.progress.removeObserver(self, forKeyPath: "fractionCompleted", context: nil)
                
        }
        self.progress.addObserver(self, forKeyPath: "fractionCompleted", options: NSKeyValueObservingOptions.New, context: nil)
        
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath !=  "fractionCompleted" {
           super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            
        }
    }
    
    //Garbage collector - Explicitly
    deinit {
       self.removeSubViews()
    }
    
    func removeSubViews(){
        self.carousel.hidden = true
        
        self.carousel.delegate = nil
        self.carousel.dataSource = nil
        self.carousel = nil
    }
    
}
