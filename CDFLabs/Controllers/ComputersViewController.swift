//
//  ComputersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class ComputersViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var refreshControl: UIRefreshControl?
    var refreshButton: UIBarButtonItem?
    
    var labData: [Lab] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.labData = [
            Lab(name: "BA 2270", avail: 27, busy: 5,  total: 32, timestamp: ""),
            Lab(name: "BA 3185", avail: 16, busy: 4,  total: 20, timestamp: ""),
            Lab(name: "BA 3175", avail: 12, busy: 5,  total: 17, timestamp: ""),
            Lab(name: "BA 3165", avail: 2,  busy: 23, total: 25, timestamp: ""),
            Lab(name: "BA 2210", avail: 13, busy: 13, total: 26, timestamp: ""),
            Lab(name: "BA 2250", avail: 19, busy: 14, total: 33, timestamp: ""),
            Lab(name: "BA 3250", avail: 6,  busy: 25, total: 31, timestamp: ""),
            Lab(name: "BA 2175", avail: 0,  busy: 27, total: 27, timestamp: ""),
            Lab(name: "BA 2185", avail: 19, busy: 2,  total: 21, timestamp: ""),
            Lab(name: "BA 2165", avail: 3,  busy: 14, total: 17, timestamp: ""),
            Lab(name: "NX",      avail: 16, busy: 14, total: 30, timestamp: ""),
            Lab(name: "GB 215",  avail: 32, busy: 3,  total: 35, timestamp: "")
        ]
        
        self.loadContentView()
        self.pushViewController(self.contentViewController!, animated: false)
        
        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        self.contentViewController!.navigationItem.rightBarButtonItem = self.refreshButton!
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
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[tableView]|", options: .AlignAllLeft, metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[tableView]|", options: .AlignAllTop, metrics: nil, views: viewsDict))
    }
    
    func loadTableView() {
        self.tableView = CLTableView()

        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        self.tableView?.addSubview(self.refreshControl!)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return LabTableViewCell(lab: self.labData[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CLTable.cellHeight + CLTable.cellPadding
    }
    
    func refresh() {
        self.tableView?.setContentOffset(CGPointMake(0, 0 - (self.tableView?.contentInset.top)! - self.refreshControl!.frame.size.height), animated: true)
        self.refreshControl!.beginRefreshing()
        self.refresh(self.refreshControl!)
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        // Simulate page load
        self.refreshButton?.enabled = false
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 1))
        dispatch_after(delayTime, dispatch_get_main_queue()){
            refreshControl.endRefreshing()
            self.refreshButton?.enabled = true
        }
    }
}
