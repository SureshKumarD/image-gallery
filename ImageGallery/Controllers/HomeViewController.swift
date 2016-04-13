//
//  HomeViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, AlbumDelegate, MenuDelegate {
    
    //Storyboard objects...
    @IBOutlet weak var galleryTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var galleryTypeContainerView: UIView!
    
    //CollectionView...
    var galleryCollectionView : GalleryCollectionView!
    var galleryViewOption : GalleryView!
    var flowLayout : UICollectionViewFlowLayout!

    
    //TableView...
    var galleryTableView : GalleryTableView!
    var menuTableView : MenuTableView!
    
    //Navigation Items...
    var leftBarButtonItem : UIBarButtonItem!
    var rightBarButtonItem : UIBarButtonItem!
    var navigationLeftButton : UIButton!
    var navigationRightButton : UIButton!
    var navigationTitleView : UIView!
    var navigationTitleLabel: UILabel!
    var navigationTitleDisclosureView : UIImageView!

    var imagesInfoArray : [AnyObject] = []
    var mainMenuDisclosed : Bool = false
    
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
        self.navigationController?.navigationBar.tintColor = kWHITE_COLOR
        self.navigationController?.navigationBar.translucent = false
        self.navigationItem.titleView?.addSubview(UIView())
        self.setNavigationLeftButton()
        
        self.setNavigationRightButton()
        self.setNavigationTitleView()
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
        self.galleryCollectionView.imagesInfoArray = self.imagesInfoArray
        GalleryCollectionView.albumDelegate = self
        self.galleryTypeContainerView.addSubview(self.galleryCollectionView)
        
        self.galleryViewOption = GalleryView.Grid
    }

    
    // TableView initial settings...
    func tableViewDefaultSettings() {
        
        self.galleryTableView = GalleryTableView(frame: self.galleryTypeContainerView.bounds , style: UITableViewStyle.Plain)
        GalleryTableView.albumDelegate = self
        self.galleryTableView.imagesInfoArray = self.imagesInfoArray
        self.galleryTypeContainerView.addSubview(self.galleryTableView)
        self.galleryTableView.hidden = true
        
        
        self.menuTableView = MenuTableView(frame: self.galleryTypeContainerView.bounds , style: UITableViewStyle.Grouped)
        MenuTableView.menuDelegate = self
        self.galleryTypeContainerView.addSubview(self.menuTableView)
        self.menuTableView.hidden = true
        
    }
    
    //Register CollectionView Nib
    func registerAllNibs() {
       
        self.galleryCollectionView.registerNib(UINib.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"GalleryCollectionViewCell")
        
    }
    
    //Handler when view did finish layout...
    func didFinishLayout() {
        self.galleryCollectionView.frame = self.galleryTypeContainerView.bounds
        self.galleryTableView.frame = self.galleryTypeContainerView.bounds
        self.menuTableView.frame = self.galleryTypeContainerView.bounds
    }
    
    
    //MARK:- Album Selected Delegate
    func albumSelected(item: AnyObject!) {
        
        self.view.userInteractionEnabled = false
        DataManager.sharedDataManager().startActivityIndicator()
        let albumID = item.albumID as String
        let urlString = "/"+API_VERSION+"/"+URL_FRAGMENT_ALBUM+"/"+albumID
        NetworkManager.getAlbumImages(urlString, success: { (imagesObjectDictionary : [String : AnyObject]?) -> Void in
            
            
            DataManager.sharedDataManager().stopActivityIndicator()
            self.view.userInteractionEnabled = true
            if let images = imagesObjectDictionary!["images"] as! [AnyObject]? {
                // Check whether images are availble
                if(images.count == 0) {
                    self.showAlertView("Zero!", message: "No, images available in this album")
                }else {
                    self.openDetailViewController(images)
                }
            }else {
                
                self.showAlertView("Error", message: "Something went wrong!")
            }
            
            }) { (error: NSError) -> Void in
                
            self.view.userInteractionEnabled = true
            DataManager.sharedDataManager().stopActivityIndicator()
                self.showAlertView("Error", message: error.localizedDescription)
        }
    }
    
    // Move to DetailViewController...
    func openDetailViewController(imagesArray : [AnyObject]) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.imagesArray = imagesArray
        
        self.navigationController?.pushViewController(detailVC, animated: false)

    }
    
    func showAlertView(title: String!, message : String!) {
        let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    
    //MARK:- Menu Delegate
    func menuSelected(selectedMenu: [String : String]) {
        self.foldMainMenu()
        let section = selectedMenu["section"] as String!
        var isAlreadyOnSameCategory = false
        
        if(Int(section) == 0) {
            let index = selectedMenu["index"] as String!
            let sharedInstance = DataManager.sharedDataManager()
            switch(Int(index)!) {
            case 0:
                if(sharedInstance.currentAlbumCategory == AlbumGategory.Hot) {
                    isAlreadyOnSameCategory = true
                }
                sharedInstance.currentAlbumCategory = AlbumGategory.Hot
                self.navigationTitleLabel.text = "Hot"
                break
            case 1:
                if(sharedInstance.currentAlbumCategory == AlbumGategory.Top) {
                    isAlreadyOnSameCategory = true
                }
                sharedInstance.currentAlbumCategory = AlbumGategory.Top
                self.navigationTitleLabel.text = "Top"
                break
            case 2:
                if(sharedInstance.currentAlbumCategory == AlbumGategory.User) {
                    isAlreadyOnSameCategory = true
                }
                sharedInstance.currentAlbumCategory = AlbumGategory.User
                self.navigationTitleLabel.text = "User"
                break
            default:
            
                sharedInstance.currentAlbumCategory = AlbumGategory.Hot
                self.navigationTitleLabel.text = "Hot"
                break
                
            }
            
            // Server call optimization, do not call the server,
            // If already on the same parameter search
            if(!isAlreadyOnSameCategory) {
                self.resetAlbumObjects()
                self.fetchAlbums()
            }
           
        }else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let appInfoVC = storyBoard.instantiateViewControllerWithIdentifier("AppInfoViewController") as! AppInfoViewController
            
            
            self.navigationController?.pushViewController(appInfoVC, animated: false)
            
        }
    }
    
    //MARK:- NavigationBar
    //Left Button...
    func setNavigationLeftButton() {
        
        if(self.navigationLeftButton == nil) {
            self.navigationLeftButton = UIButton(type: UIButtonType.System)
        }
        self.navigationLeftButton.setTitle("Viral", forState: UIControlState.Normal)
        self.navigationLeftButton.setTitleColor(kWHITE_COLOR, forState: UIControlState.Normal)
        self.navigationLeftButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
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
        self.navigationRightButton.tintColor = kWHITE_COLOR
        self.navigationRightButton.imageView?.contentMode = UIViewContentMode.Center
        self.navigationRightButton.addTarget(self, action: Selector("changeGalleryView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.rightBarButtonItem.customView = self.navigationRightButton
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem

    }
    
    //Title View... 
    func setNavigationTitleView() {
        self.navigationTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        self.navigationTitleLabel = UILabel(frame: CGRect(x: 0, y: 17, width: self.navigationTitleView.frame.size.width, height: 21))
        self.navigationTitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 17)
        self.navigationTitleLabel.textColor = kWHITE_COLOR
        self.navigationTitleLabel.text = "Hot"
        self.navigationTitleLabel.textAlignment = NSTextAlignment.Center
        self.navigationTitleDisclosureView = UIImageView(frame: CGRect(x: self.navigationTitleView.frame.size.width/2 - 10, y: 38, width: 21, height: 12))
        self.navigationTitleDisclosureView.contentMode = UIViewContentMode.ScaleAspectFit
        self.navigationTitleDisclosureView.image = UIImage(named: "DownArrow")
        self.navigationTitleDisclosureView.image? = (self.navigationTitleDisclosureView.image?.imageWithRenderingMode(.AlwaysTemplate))!
        self.navigationTitleDisclosureView.tintColor = kWHITE_COLOR
        self.navigationTitleView.addSubview(self.navigationTitleLabel)
        self.navigationTitleView.addSubview(self.navigationTitleDisclosureView)
        self.navigationItem.titleView = self.navigationTitleView;
        
        self.setTapGesture()
    }
    
    //TapGesture for Navigation TitleView
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("titleViewTapped"))
        self.navigationTitleView.userInteractionEnabled = true
        self.navigationTitleView.addGestureRecognizer(tapGesture)
    }
    
    
    //TapGesture handler 
    func titleViewTapped() {
        self.mainMenuDisclosed = !self.mainMenuDisclosed
        if(self.mainMenuDisclosed) {
            self.unFoldMainMenu()
        }else {
            self.foldMainMenu()
        }
    }
    
    //Open MainMenu
    func unFoldMainMenu() {
        self.navigationTitleView.userInteractionEnabled = false
        self.menuTableView.hidden = false
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.TransitionFlipFromBottom, animations: { () -> Void in
            let frame = self.galleryTypeContainerView.frame
            self.menuTableView.frame = frame
            self.navigationTitleDisclosureView.image = UIImage(named: "UpArrow")
            self.navigationTitleDisclosureView.image? = (self.navigationTitleDisclosureView.image?.imageWithRenderingMode(.AlwaysTemplate))!
            self.navigationTitleDisclosureView.tintColor = kWHITE_COLOR
            }) { (Bool) -> Void in
                
                self.navigationRightButton.userInteractionEnabled = false
                self.navigationLeftButton.userInteractionEnabled = false
                self.navigationTitleView.userInteractionEnabled = true
               
            
        }

    }
    
    //Close MainMenu
    func foldMainMenu() {
        self.navigationTitleView.userInteractionEnabled = false
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.TransitionFlipFromTop, animations: { () -> Void in
            var frame = self.galleryTypeContainerView.frame
            frame.origin.y = (self.galleryTypeContainerView.frame.size.height + 64) * -1
            self.menuTableView.frame = frame
            self.navigationTitleDisclosureView.image = UIImage(named: "DownArrow")
            self.navigationTitleDisclosureView.image? = (self.navigationTitleDisclosureView.image?.imageWithRenderingMode(.AlwaysTemplate))!
            self.navigationTitleDisclosureView.tintColor = kWHITE_COLOR
            }) { (Bool) -> Void in
                self.menuTableView.hidden = true
                self.navigationRightButton.userInteractionEnabled = true
                self.navigationLeftButton.userInteractionEnabled = true
                self.navigationTitleView.userInteractionEnabled = true
                
                
        }

    }
    
    //MARK:- Navigation Bar Action
    //Right button action handler...
    func changeGalleryView() {
        var image :UIImage!
        switch(self.galleryViewOption) {
            
        case GalleryView.Staggered? :
            self.galleryViewOption = GalleryView.List
            image = UIImage(named: "listIcon")
            self.changeViewOptionToList()
            break
            
        case GalleryView.List?:
            self.galleryViewOption = GalleryView.Grid
             image = UIImage(named: "gridIcon")
            self.changeViewOptionToGrid()
            break
       
        case GalleryView.Grid? :
            self.galleryViewOption = GalleryView.Staggered
            image = UIImage(named: "staggeredGridIcon")
            self.changeViewOptionToStaggeredGrid()
            break
            
        default:
            break
        }
        
        
        
        let newImage =   image?.imageWithRenderingMode(.AlwaysTemplate) as UIImage!
        
        self.navigationRightButton.setImage(newImage, forState: .Normal)
        self.navigationRightButton.tintColor = kWHITE_COLOR
        
    }
    
    //Left button action handler...
    func fetchGalleyWithViralOption() {
        self.resetAlbumObjects()
        if(DataManager.sharedDataManager().isViral) {
           self.navigationLeftButton.setTitleColor(kWHITE_COLOR, forState: UIControlState.Normal)
        }else {
            self.navigationLeftButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
        self.fetchAlbums()
        
    }
    
    //Reset Albums already in hand....
    func resetAlbumObjects() {
        DataManager.sharedDataManager().isViral = !DataManager.sharedDataManager().isViral
        self.galleryTableView.imagesInfoArray = []
        self.galleryCollectionView.imagesInfoArray = []

    }
    

    //MARK:- Change view option
    //To Grid View
    func changeViewOptionToGrid() {
        self.galleryCollectionView.hidden = false
        self.galleryTableView.hidden = true
        self.flowLayout.minimumInteritemSpacing = 5
        self.galleryCollectionView.viewOption = GalleryView.Grid
        self.galleryCollectionView.imagesInfoArray = self.galleryTableView.imagesInfoArray
        self.galleryCollectionView.reloadData()
    }
    
    //To Staggered Grid
    func changeViewOptionToStaggeredGrid() {
        self.galleryCollectionView.hidden = false
        self.galleryTableView.hidden = true
        self.flowLayout.minimumInteritemSpacing = 0
        self.galleryCollectionView.viewOption = GalleryView.Staggered
        self.galleryCollectionView.imagesInfoArray = self.galleryTableView.imagesInfoArray
        self.galleryCollectionView.reloadData()
    }

    //To List View
    func changeViewOptionToList() {
        self.galleryCollectionView.hidden = true
        self.galleryTableView.hidden = false
        self.galleryTableView.imagesInfoArray = self.galleryCollectionView.imagesInfoArray
        self.galleryTableView.reloadData()
    }
    
    //Fetch albums with the Global constants available in hand...
    func fetchAlbums() {
        let sharedInstance = DataManager.sharedDataManager()
        sharedInstance.currentPage = 0
        sharedInstance.isRequiredLoadNextPage = false
        sharedInstance.startActivityIndicator()
        self.view.userInteractionEnabled  = false
        self.navigationController?.navigationBar.userInteractionEnabled = false
        NetworkManager.fetchAlbums(sharedInstance.currentAlbumCategory, isViral: sharedInstance.isViral, pageNumber: sharedInstance.currentPage,  handler:{
            (objects:[AnyObject]!) -> Void in
            self.galleryCollectionView.imagesInfoArray = objects
            self.galleryTableView.imagesInfoArray = objects
            self.galleryCollectionView.reloadData()
            self.galleryTableView.reloadData()
            sharedInstance.stopActivityIndicator()
            self.view.userInteractionEnabled  = true
            self.navigationController?.navigationBar.userInteractionEnabled = true
            
        })
        
    }

    
    
    
    
    

}

