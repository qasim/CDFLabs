//
//  ComputersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit
import Just

class ComputersViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var refreshControl: UIRefreshControl?
    var refreshButton: UIBarButtonItem?
    
    var labData: [Lab] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.labData = [
            Lab(name: "BA 2200", avail: 6,  busy: 25, total: 31),
            Lab(name: "BA 2210", avail: 16, busy: 4,  total: 20),
            Lab(name: "BA 2220", avail: 12, busy: 5,  total: 17),
            Lab(name: "BA 2240", avail: 2,  busy: 23, total: 25),
            Lab(name: "BA 2270", avail: 0, busy: 32,  total: 32),
            Lab(name: "BA 3175", avail: 19, busy: 14, total: 33),
            Lab(name: "BA 3185", avail: 13, busy: 13, total: 26),
            Lab(name: "BA 3195", avail: 19, busy: 2,  total: 21),
            Lab(name: "BA 3200", avail: 0,  busy: 27, total: 27),
            Lab(name: "GB 215",  avail: 32, busy: 3,  total: 35),
            Lab(name: "NX",      avail: 63, busy: 5, total: 68)
        ]
        
        self.loadContentView()
        self.pushViewController(self.contentViewController!, animated: false)
        
        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self,
                                             action: #selector(self.refresh as Void -> Void))
        self.contentViewController!.navigationItem.rightBarButtonItem = self.refreshButton!
        
        /*
        let infoButton = UIButton(type: .InfoLight)
        infoButton.tintColor = UIColor.whiteColor()
        infoButton.addTarget(self, action: #selector(self.info), forControlEvents: .TouchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        self.contentViewController!.navigationItem.leftBarButtonItem = infoBarButton
        */
        
        // self.refresh()

        if NSUserDefaults.standardUserDefaults().isFirstLaunch() {
            PopupView.showFirstLaunchPopup()
        }
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Computers"
        
        let contentView = self.contentViewController!.view

        self.loadTableView()
        contentView.addSubview(self.tableView!)
        
        let viewsDict: [String: AnyObject] = [
            "tableView": self.tableView!
        ]
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[tableView]|", options: options, metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[tableView]|", options: options, metrics: nil, views: viewsDict))
    }
    
    func loadTableView() {
        self.tableView = CLTableView()

        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)),
                                       forControlEvents: .ValueChanged)
        self.tableView?.addSubview(self.refreshControl!)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labData.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return LabTableViewCell(lab: self.labData[indexPath.row])
    }
    
    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CLTable.cellHeight + CLTable.cellPadding
    }
    
    func refresh() {
        self.tableView?.setContentOffset(
            CGPointMake(0,
                self.tableView!.contentOffset.y - self.refreshControl!.frame.size.height),
            animated: true)
        self.refreshControl!.beginRefreshing()
        self.refresh(self.refreshControl!)
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        Just.get("http://www.cdf.toronto.edu/~g3cheunh/cdflabs.json") { (r) in
            if r.ok {
                if let json = r.json as? [String:AnyObject] {
                    if let labs = json["labs"] as? [[String: AnyObject]] {
                        self.labData = []
                        for lab in labs {
                            let name = lab["name"] as! String
                            let avail = lab["available"] as! Int
                            let busy = lab["busy"] as! Int
                            let total = lab["total"] as! Int
                            self.labData.append(
                                Lab(name: name,
                                    avail: avail,
                                    busy: busy,
                                    total: total))
                        }
                    }
                }
            }
            
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.tableView?.reloadData()
            })
            refreshControl.endRefreshing()
            CATransaction.commit()
        }
    }
}
