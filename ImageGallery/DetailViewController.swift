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
    var imagesArray :[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .CoverFlow2
        carousel.dataSource = self
        carousel.delegate = self
        for i in 0...5
        {
            self.imagesArray.append(i)
        }
        self.carousel.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setGradientBackground()
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
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor.blackColor().CGColor]
        self.view.layer.insertSublayer(gradient, atIndex: 0)
    }

    //MARK:- Carousel Implementation
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return self.imagesArray.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var label: UILabel
        var itemView: UIImageView
        
        //create new view if no view is available for recycling
        if (view == nil)
        {
            //don't do anything specific to the index within
            //this `if (view == nil) {...}` statement because the view will be
            //recycled and used with other index values later
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:200, height:200))
            itemView.image = UIImage(named: "page.png")
            itemView.contentMode = .Center
            
            label = UILabel(frame:itemView.bounds)
            label.backgroundColor = UIColor.whiteColor()
            label.alpha = 0.5
            label.textAlignment = .Center
            label.font = label.font.fontWithSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        else
        {
            //get a reference to the label in the recycled view
            itemView = view as! UIImageView;
            label = itemView.viewWithTag(1) as! UILabel!
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(self.imagesArray[index])"
        
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

}
