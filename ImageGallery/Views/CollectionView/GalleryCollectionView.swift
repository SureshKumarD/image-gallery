//
//  GalleryCollectionView.swift
//  ImageGallery
//
//  Created by Suresh on 4/7/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit


public class GalleryCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    

    
    //local object
    public var imageInfoArray = []
    
    //Delegate to pass data
    static var itemDelegate : ItemDelegate!
    
    
    
    var viewOption : GalleryView!
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.imageInfoArray = DataManager.sharedDataManager().objects
        self.viewOption = GalleryView.Staggered
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CollectionView Datasources
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageInfoArray.count
    }
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GalleryCollectionViewCell", forIndexPath: indexPath) as! GalleryCollectionViewCell
        
        let object = self.imageInfoArray[indexPath.row]
        let coverImage = object.coverImage() as IMGImage
        var url : NSURL!
        if(self.viewOption == GalleryView.Grid) {
            url = coverImage.URLWithSize(IMGSize.LargeThumbnailSize) as NSURL
        }else {
            url = coverImage.URLWithSize(IMGSize.SmallThumbnailSize) as NSURL
        }
       
        cell.albumTitleLabel.text = object.valueForKey("title") as? String
        cell.albumImageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.CacheMemoryOnly)
        cell.albumUpsLabel.text = SYMBOL_UP_ARROW+"\(object.ups)"
        cell.albumDownsLabel.text = SYMBOL_DOWN_ARROW+"\(object.downs)"
        return cell
    }

    
    public func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
       return UICollectionReusableView()
    }
   
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if(self.viewOption == GalleryView.Grid) {
            return CGSizeMake(WIDTH_WINDOW_FRAME - 20, 230)
        }else {
            return CGSizeMake((WIDTH_WINDOW_FRAME/2) - 2.5, 230)
        }
    }
//    
    //MARK:- CollectionView Delegates
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object = self.imageInfoArray[indexPath.row]
        GalleryCollectionView.itemDelegate .itemSelected(object)
        
    }
    
    
    
//    #pragma mark - ScrollView
//    
//    - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//    
//    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height)) {
//    
//    if(_isPageRefresing == NO){
//    _isPageRefresing = YES;
//    _currentpagenumber = _currentpagenumber +1;
//    [self getResults:_currentpagenumber];
//    }
//    }
//    
//    }
//    
//    /**
//    * Update the UI once data has been fetched successfully.
//    **/
//    -(void)updateTableViewWithResults:(NSArray *)results forPage:(NSInteger)pageNo{
//    if(pageNo == 1){
//    self.searchResults = [results mutableCopy];
//    }
//    else{
//    [self.searchResults addObjectsFromArray:results];
//    }
//    _isPageRefresing = NO;
//    [self.tableView reloadData];
//    }
//    
//    
//    -(void)getResults:(NSInteger)pageNumber{
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@&page=%d&per_page=50",BASE_URL,URL_SEARCH_REPOS, URL_SEARCH_REPO_QUERY_FRAGMENT,_searchedText,URL_SEARCH_REPO_TRAIL_FRAGMENT,(int)pageNumber ];
//    NSLog(@"urlString %@",urlString);
//    [APP_DELEGATE_INSTANCE.netWorkObject  getResponseWithUrl:urlString  withRequestApiName:REPOS withCompletionHandler:^(id response, NSError *error) {
//    //        NSLog(@"%@", response);
//    [self updateTableViewWithResults:[response valueForKey:@"items"] forPage:_currentpagenumber];
//    }];
//    
//    }
//    
//    - (void)stopAllNetworkCalls {
//    [APP_DELEGATE_INSTANCE.netWorkObject cancelAllRequests];
//    }
//    @end
//    
    
    

}
