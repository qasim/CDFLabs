//
//  PrintersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class PrintersViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var refreshControl: UIRefreshControl?
    var refreshButton: UIBarButtonItem?
    
    var printerData: [Printer] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.printerData = [
            Printer(name: "P2210b", description: "Kyocera Network Printer in BA2210", jobs: []),
            Printer(name: "P3175a", description: "Kyocera Network Printer in BA3175", jobs: [
                PrintJob()
            ]),
            Printer(name: "P2210a", description: "Kyocera Network Printer in BA2210", jobs: [
                PrintJob(),
                PrintJob()
            ])
        ]
        
        self.loadContentView()
        self.pushViewController(contentViewController!, animated: false)
        
        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        self.contentViewController!.navigationItem.rightBarButtonItem = self.refreshButton!
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Printers"
        
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
        self.tableView?.addSubview(refreshControl!)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printerData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return PrinterTableViewCell(printer: self.printerData[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CLTable.printerCellHeight + CLTable.cellPadding
    }
    
    func refresh() {
        self.tableView?.setContentOffset(CGPointMake(0, self.tableView!.contentOffset.y - self.refreshControl!.frame.size.height), animated: true)
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
