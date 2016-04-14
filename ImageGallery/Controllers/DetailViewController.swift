//
//  DetailViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/9/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate {

   
   
    @IBOutlet weak var albumContainerView: UIView!
    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var albumContainerViewHeightConstraint: NSLayoutConstraint!
   
    var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imagesArray  = []
    var progress = NSProgress()
    var currentPhotoIndex : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView = UITableView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let centerPoint : CGPoint  = self.tableView.center
        self.tableView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/(-2))
        self.tableView.center = centerPoint;
       
        self.tableView.frame = self.tableContainerView.bounds
        self.tableView.backgroundColor = kBLACK_COLOR
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableContainerView .addSubview(self.tableView)
        self.pageControl.numberOfPages = self.imagesArray.count
        self.title = "Album"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.hideAllSubviews()
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
    
    override func didFinishLayout() {
        let centerPoint : CGPoint  = self.tableView.center
        self.tableView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/(-2))
        self.tableView.center = centerPoint;
        
        self.albumContainerViewHeightConstraint.constant = WIDTH_WINDOW_FRAME
        self.tableView.frame = self.tableContainerView.bounds
    }
    
    func hideAllSubviews() {
        self.tableView.hidden = true
        self.pageControl.hidden = true
    }
    
    func unHideAllSubviews() {
        self.tableView.hidden = false
        self.pageControl.hidden = false
    }
    
    //Preload images
    func preloadAlbumImages() {
        DataManager.sharedDataManager().startActivityIndicator()
        var imageUrlsArray :[AnyObject]! = []
        for image in self.imagesArray {
            imageUrlsArray.append(image["link"]as! String)

        }
        
        
        SDWebImagePrefetcher.sharedImagePrefetcher().prefetchURLs(imageUrlsArray, progress: { (int1 : UInt, int2 : UInt) -> Void in
            self.unHideAllSubviews()
//            self.carousel?.hidden = false
            
            
            }) { (int1 : UInt, int2 :UInt) -> Void in
//                self.carousel?.hidden = false
//                self.carousel?.reloadData()
                DataManager.sharedDataManager().stopActivityIndicator()
//                self.progress.removeObserver(self, forKeyPath: "fractionCompleted", context: nil)
                
        }
        
    }
    
    //Garbage collector - Explicitly
    deinit {
       self.removeSubViews()
    }
    
    func removeSubViews(){

        DataManager.sharedDataManager().stopActivityIndicator()
    }
    
    
    //MARK:- TableView Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return NUMBER_ONE
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.imagesArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AlbumImageCell") as? AlbumImageCell
        if cell == nil {
            tableView.registerNib(UINib(nibName: "AlbumImageCell", bundle: nil), forCellReuseIdentifier: "AlbumImageCell")
    
            cell = tableView.dequeueReusableCellWithIdentifier("AlbumImageCell") as? AlbumImageCell
            
        }
        cell?.albumImageView.contentMode = UIViewContentMode.ScaleAspectFill
        cell?.frame = CGRect(x: 0, y: 0, width: WIDTH_WINDOW_FRAME, height: WIDTH_WINDOW_FRAME)
        cell?.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        let imageObject = self.imagesArray[indexPath.row] as! [String: AnyObject]
        let url = imageObject["link"]as! String
       
        cell?.albumImageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "placeholder2"), options: SDWebImageOptions.CacheMemoryOnly)
        cell?.albumImageView.contentMode = UIViewContentMode.ScaleAspectFill
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         return WIDTH_WINDOW_FRAME
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let photoVC = storyBoard.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
        let imageObject = self.imagesArray[indexPath.row] as! [String: AnyObject]
        let url = imageObject["link"]as! String
        
        photoVC.imageUrl = url
        
        
        let navigationController = UINavigationController(rootViewController: photoVC)
    
        navigationController.navigationBar.barTintColor = UIColor.clearColor()
        navigationController.navigationBar.barStyle = UIBarStyle.Black
        navigationController.navigationBar.tintColor = kWHITE_COLOR
        navigationController.navigationBar.translucent = false

        self.navigationController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth :Int = Int(WIDTH_WINDOW_FRAME)
        let pageX : Int = self.currentPhotoIndex * pageWidth - Int(scrollView.contentInset.left);
        if(Int(targetContentOffset.memory.y) < pageX) {
            if(self.currentPhotoIndex > 0) {
                self.currentPhotoIndex--
            }
            
        }else if(Int(targetContentOffset.memory.y) > pageX) {
            if(self.currentPhotoIndex < self.imagesArray.count) {
                self.currentPhotoIndex++
            }
        }
        targetContentOffset.memory.y = CGFloat(self.currentPhotoIndex * pageWidth) - scrollView.contentInset.left
        self.pageControl.currentPage = self.currentPhotoIndex

        
    }
    
    

}
