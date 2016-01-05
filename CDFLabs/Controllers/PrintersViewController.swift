//
//  PrintersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit
import Just

class PrintersViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var refreshControl: UIRefreshControl?
    var refreshButton: UIBarButtonItem?
    
    var printerData: [Printer] = []
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        /*self.printerData = [
            Printer(name: "P2210b", description: "Kyocera Network Printer in BA2210", jobs: []),
            Printer(name: "P3175a", description: "Kyocera Network Printer in BA3175", jobs: [
                PrintJob()
            ]),
            Printer(name: "P2210a", description: "Kyocera Network Printer in BA2210", jobs: [
                PrintJob(),
                PrintJob()
            ])
        ]*/
        
        self.loadContentView()
        
        self.pushViewController(contentViewController!, animated: false)
        
        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
        self.contentViewController!.navigationItem.rightBarButtonItem = self.refreshButton!
        
        self.refresh()
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
        
        let options = NSLayoutFormatOptions(rawValue: 0)
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[tableView]|", options: options, metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[tableView]|", options: options, metrics: nil, views: viewsDict))
    }
    
    func loadTableView() {
        self.tableView = CLTableView()
        self.tableView?.estimatedRowHeight = CLTable.printerCellHeight
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
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
    
    func refresh() {
        self.tableView?.setContentOffset(CGPointMake(0, self.tableView!.contentOffset.y - self.refreshControl!.frame.size.height), animated: true)
        self.refreshControl!.beginRefreshing()
        self.refresh(self.refreshControl!)
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        Just.get("http://www.cdf.toronto.edu/~g3cheunh/cdfprinters.json") { (r) in
            if r.ok {
                if let json = r.json as? [String:AnyObject] {
                    self.printerData = []
                    let printers = json["printers"] as! [String:AnyObject]
                    
                    for (rawName, info) in printers {
                        let name = rawName.titleCaseString
                        
                        let rawJobs = info["jobs"] as! [[String:String]]
                        var jobs: [PrintJob] = []
                        for job in rawJobs {
                            if job["rank"] != "done" {
                                jobs.append(PrintJob())
                            }
                        }
                        
                        var description = info["description"] as! String
                        description = description.replace("'", withString: "")
                        
                        let printer = Printer(name: name, description: description, jobs: jobs)
                        self.printerData.append(printer)
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
