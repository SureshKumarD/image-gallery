//
//  HomeViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ItemDelegate {
    
    //Storyboard objects...
    @IBOutlet weak var galleryTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var galleryTypeContainerView: UIView!
    
    //CollectionView...
    var galleryCollectionView : GalleryCollectionView!
    var galleryViewOption : GalleryView!
    var flowLayout : UICollectionViewFlowLayout!

    
    //TableView...
    var galleryTableView : GalleryTableView!
    
    
    //Navigation Items...
    var leftBarButtonItem : UIBarButtonItem!
    var rightBarButtonItem : UIBarButtonItem!
    var navigationLeftButton : UIButton!
    var navigationRightButton : UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Allocations/ Initializations
        self.galleryViewOption = GalleryView.Staggered
        self.initializations()
        self.registerAllNibs()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.sampleApiHit()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: Selector("didFinishLayout"), object: nil)
        self.performSelector(Selector("didFinishLayout"), withObject: nil, afterDelay: 0)
    }
    
    
    //MARK:- METHODS
    
    //MARK:- Initial setups
    func initializations () {
    
        //Collection & Table Views
        self.collectionViewDefaultSettings()
        self.tableViewDefaultSettings()
        
        
        //Navigation Bar
        self.leftBarButtonItem = UIBarButtonItem()
        self.rightBarButtonItem = UIBarButtonItem()
        self.navigationBarDefaultSettings()
        
    }
    
    //Do Navigation bar initial settings...
    func  navigationBarDefaultSettings() {
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = false
        self.setNavigationLeftButton()
        self.setNavigationRightButton()
        self.changeGalleryView()

    }
    
    
    //CollectionView initial settings... 
    func collectionViewDefaultSettings() {
        //CollectionView...
        self.flowLayout  = UICollectionViewFlowLayout()
        self.flowLayout.minimumInteritemSpacing = 2.5
        self.flowLayout.minimumLineSpacing = 5
        
        self.galleryCollectionView = GalleryCollectionView(frame: self.galleryTypeContainerView.bounds , collectionViewLayout: flowLayout)
        self.galleryCollectionView.viewOption = self.galleryViewOption
        GalleryCollectionView.itemDelegate = self
        self.galleryCollectionView.imageInfoArray = DataManager.sharedDataManager().objects
        self.galleryTypeContainerView.addSubview(self.galleryCollectionView)
        self.galleryViewOption = GalleryView.Grid
    }

    
    // TableView initial settings...
    func tableViewDefaultSettings() {
        
        self.galleryTableView = GalleryTableView(frame: self.galleryTypeContainerView.bounds , style: UITableViewStyle.Plain)
        GalleryTableView.itemDelegate = self
        self.galleryTableView.imageInfoArray = DataManager.sharedDataManager().objects
        self.galleryTypeContainerView.addSubview(self.galleryTableView)
        self.galleryTableView.hidden = true
    }
    
    //Register CollectionView Nib
    func registerAllNibs() {
       
        self.galleryCollectionView.registerNib(UINib.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"GalleryCollectionViewCell")
        
    }
    
    //Handler when view did finish layout...
    func didFinishLayout() {
        self.galleryCollectionView.frame = self.galleryTypeContainerView.bounds
        self.galleryTableView.frame = self.galleryTypeContainerView.bounds

    }
    
    
    func sampleApiHit() {
       
        
        IMGGalleryRequest.hotGalleryPage(0, success: { (objects: [AnyObject]!) -> Void in
            print(objects)
            }) { (error : NSError!) -> Void in
                
        }
        
        
    }
    
    //MARK:- Item Selected Delegate
    func itemSelected(item: AnyObject!) {
        
        self.view.userInteractionEnabled = false
        DataManager.sharedDataManager().startActivityIndicator()
        let albumID = item.albumID as String
        let urlString = "/"+API_VERSION+"/"+URL_FRAGMENT_ALBUM+"/"+albumID
        NetworkManager.getAlbumImages(urlString, success: { (imagesObjectDictionary : [String : AnyObject]?) -> Void in
            
            
            DataManager.sharedDataManager().stopActivityIndicator()
//            self.view.userInteractionEnabled = true
            self.openDetailViewController()
//            self.openDetailViewController(imagesObjectDictionary!["data"] as! [AnyObject]!)
            }) { (error: NSError) -> Void in
                
            self.view.userInteractionEnabled = true
            DataManager.sharedDataManager().stopActivityIndicator()
        }
    }
    
    func openDetailViewController() {
//    func openDetailViewController(imagesArray : [AnyObject]) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
//        detailVC.imagesArray = imagesArray
        
        self.navigationController?.pushViewController(detailVC, animated: false)

    }
    
    //MARK:- NavigationBar
    //Left Button...
    func setNavigationLeftButton() {
        
        if(self.navigationLeftButton == nil) {
            self.navigationLeftButton = UIButton(type: UIButtonType.System)
        }
        self.navigationLeftButton.setTitle("Viral", forState: UIControlState.Normal)
        self.navigationLeftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.navigationLeftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        self.navigationLeftButton.frame = CGRectMake(0, 0, 50, 50)
        self.navigationLeftButton.imageEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        self.navigationLeftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10)
        self.navigationLeftButton.imageView?.contentMode = UIViewContentMode.Center
        self.navigationLeftButton.addTarget(self, action: Selector("fetchGalleyWithViralOption"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.leftBarButtonItem.customView = self.navigationLeftButton
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        
        

    }
    
    //Right Button...
    func setNavigationRightButton() {
        if(self.navigationRightButton == nil) {
            self.navigationRightButton = UIButton(type: UIButtonType.System)
        }
        self.navigationRightButton.frame = CGRectMake(0, 0, 50, 50)
        self.navigationRightButton.imageEdgeInsets = UIEdgeInsetsMake(12,12,12,12)
        self.navigationRightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10)
        self.navigationRightButton.tintColor = UIColor.whiteColor()
        self.navigationRightButton.imageView?.contentMode = UIViewContentMode.Center
        self.navigationRightButton.addTarget(self, action: Selector("changeGalleryView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.rightBarButtonItem.customView = self.navigationRightButton
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem

    }
    
    
    //MARK:- Navigation Bar Action
    //Right button action handler...
    func changeGalleryView() {
        var image :UIImage!
        switch(self.galleryViewOption) {
            
        case GalleryView.Staggered? :
            self.galleryViewOption = GalleryView.List
            image = UIImage(named: "List")
            self.changeViewOptionToList()
            break
            
            
        case GalleryView.List?:
            self.galleryViewOption = GalleryView.Grid
             image = UIImage(named: "Grid")
            self.changeViewOptionToGrid()
            break
       
        case GalleryView.Grid? :
            self.galleryViewOption = GalleryView.Staggered
            image = UIImage(named: "StaggeredGrid")
            self.changeViewOptionToStaggeredGrid()
            break
        default:
            break
        }
        
        self.navigationRightButton.setImage(image, forState: UIControlState.Normal)
        
        
    }
    
    //Left button action handler...
    func fetchGalleyWithViralOption() {
        DataManager.sharedDataManager().isViral = !DataManager.sharedDataManager().isViral
        if(DataManager.sharedDataManager().isViral) {
           self.navigationLeftButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }else {
            self.navigationLeftButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        
    }
    

    //MARK:- Change view option
    //To Grid View
    func changeViewOptionToGrid() {
        self.galleryCollectionView.hidden = false
        self.galleryTableView.hidden = true
        self.flowLayout.minimumInteritemSpacing = 5
        self.galleryCollectionView.viewOption = GalleryView.Grid
        self.galleryCollectionView.reloadData()
    }
    
    //To Staggered Grid
    func changeViewOptionToStaggeredGrid() {
        self.galleryCollectionView.hidden = false
        self.galleryTableView.hidden = true
        self.flowLayout.minimumInteritemSpacing = 0
        self.galleryCollectionView.viewOption = GalleryView.Staggered
        self.galleryCollectionView.reloadData()
    }

    //To List View
    func changeViewOptionToList() {
        self.galleryCollectionView.hidden = true
        self.galleryTableView.hidden = false
        
        self.galleryTableView.reloadData()
    }
    

}

