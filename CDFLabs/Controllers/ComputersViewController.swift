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
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 2270", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: ""),
            Lab(lab: "BA 3200", avail: 0, busy: 0, total: 0, percent: 0.0, timestamp: "")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}
