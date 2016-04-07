//
//  ViewController.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Storyboard objects...
    @IBOutlet weak var galleryTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var galleryTypeContainerView: UIView!
    var galleryCollectionView : GalleryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Allocations/ Initializations
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
    //MARK:- Methods
    
    //MARK:-
    //MARK:- Initial setups
    func initializations () {
        
        //CollectionView...
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 10

        self.galleryCollectionView = GalleryCollectionView(frame: self.galleryTypeContainerView.bounds,    collectionViewLayout: flowLayout)
        self.galleryTypeContainerView.addSubview(galleryCollectionView)
        
    }

    func registerAllNibs() {
       
        self.galleryCollectionView.registerNib(UINib.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"GalleryCollectionViewCell")
        
    }
    
    func didFinishLayout() {
        self.galleryCollectionView.frame = self.galleryTypeContainerView.bounds

    }
    
    
    func sampleApiHit() {
        APP_DELEGATE_INSTANCE?.networkObject .requestServer("gallery/hot/viral/0.json", type: ServerRequestType.Get, completionHandler: { (result, error) -> Void in
            
        })
        
    }
    

}

