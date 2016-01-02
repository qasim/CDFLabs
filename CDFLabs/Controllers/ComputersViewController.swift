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
    var sortSegmentedControl: UISegmentedControl?
    
    var labData: [Lab] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.labData = [
            Lab(lab: "BA 2270", avail: 27, busy: 5, total: 32, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 3185", avail: 16, busy: 4, total: 20, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 3175", avail: 12, busy: 5, total: 17, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 3165", avail: 2, busy: 23, total: 25, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2210", avail: 13, busy: 13, total: 26, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2250", avail: 19, busy: 14, total: 33, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 3250", avail: 6, busy: 25, total: 31, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2175", avail: 4, busy: 23, total: 27, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2185", avail: 19, busy: 2, total: 21, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2165", avail: 3, busy: 14, total: 17, percent: 0.0, timestamp: ""),
            Lab(lab: "NX", avail: 16, busy: 14, total: 30, percent: 0.0, timestamp: ""),
            Lab(lab: "GB 215", avail: 32, busy: 3, total: 35, percent: 0.0, timestamp: ""),
        ]
        
        self.loadContentView()
        self.pushViewController(self.contentViewController!, animated: false)
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
        self.tableView = LabTableView()

        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        self.tableView?.addSubview(refreshControl)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return LabTableViewCell(lab: self.labData[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LabTable.cellHeight + LabTable.cellPadding
    }
    
    func refresh() {
        // TODO
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}
