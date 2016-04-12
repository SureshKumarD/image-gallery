//
//  MenuTableView.swift
//  ImageGallery
//
//  Created by Suresh on 4/11/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

import UIKit



class MenuTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var menuTitlesArray :[String]!
    
    //Delegate to pass data
    static var menuDelegate : MenuDelegate!
    
    

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.menuTitlesArray = ["Hot", "Top", "User"]
        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableFooterView = UIView(frame: CGRectZero)
    
        self.backgroundColor = kBLACK_COLOR
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
        self.menuTitlesArray = ["Hot", "Top", "User"]
        self.backgroundColor = kBLACK_COLOR
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return NUMBER_TWO
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == NUMBER_ZERO) {
            return NUMBER_THREE
        }else {
            return NUMBER_ONE
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
            cell?.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
            cell?.textLabel?.textColor = kWHITE_COLOR
            cell?.textLabel?.backgroundColor = UIColor.grayColor()
            cell?.textLabel?.layer.masksToBounds = true
            cell.textLabel?.layer.cornerRadius = 5.0
            cell.backgroundColor = UIColor.blackColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
        }
        
        if(indexPath.section == NUMBER_ZERO) {
            cell?.textLabel?.text = self.menuTitlesArray[indexPath.row]
        }else {
            cell?.textLabel?.text = "About"
        }
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == NUMBER_ZERO) {
            return "Album Category"
        }else {
            return "App Information"
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        let dictionary = ["section" : String(indexPath.section), "index" : String(indexPath.row)]
        MenuTableView.menuDelegate.menuSelected(dictionary)
        
    }
    

    

}
