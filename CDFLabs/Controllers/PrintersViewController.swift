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
    
    var printerData: [Printer] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.printerData = [
            Printer(),
            Printer(),
            Printer()
        ]
        
        self.loadContentView()
        self.pushViewController(contentViewController!, animated: false)
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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        self.tableView?.addSubview(refreshControl)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printerData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return PrinterTableViewCell(printer: self.printerData[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CLTable.cellHeight + CLTable.cellPadding
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
    }
}
