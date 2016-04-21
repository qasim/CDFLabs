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
        
        self.printerData = [
            Printer(name: "P2210a", description: "Kyocera Network Printer in BA2210",
                jobs: [
                    PrintJob(owner: "g5vicli@", rank: "done", size: "431613", time: "12:52:41"),
                    PrintJob(owner: "g4joe@", rank: "stalled", size: "139434", time: "13:02:38"),
                    PrintJob(owner: "g2juan@", rank: "2", size: "1841531", time: "15:39:36"),
                    PrintJob(owner: "g2juan@", rank: "3", size: "1956348", time: "15:39:37"),
                    PrintJob(owner: "g3mary@", rank: "4", size: "223422", time: "15:42:54"),
                    PrintJob(owner: "g3mary@", rank: "5", size: "221583", time: "15:42:54"),
                    PrintJob(owner: "g3mary@", rank: "6", size: "518310", time: "15:42:55"),
                    PrintJob(owner: "g5seung@", rank: "7", size: "960694", time: "15:43:02"),
                    PrintJob(owner: "g5seung@", rank: "8", size: "1199044", time: "15:43:02"),
                    PrintJob(owner: "g5seung@", rank: "9", size: "1547443", time: "15:43:02"),
                    PrintJob(owner: "g5seung@", rank: "10", size: "1649745", time: "15:43:03"),
                    PrintJob(owner: "g5seung@", rank: "11", size: "1405074", time: "15:43:03")
                ]),
            Printer(name: "P2210b", description: "Kyocera Network Printer in BA2210",
                jobs: [
                    PrintJob(owner: "g5wan@", rank: "done", size: "223422", time: "14:02:26"),
                    PrintJob(owner: "g3jill@", rank: "active", size: "377822", time: "14:03:13"),
                    PrintJob(owner: "g3anna@", rank: "2", size: "247763", time: "14:03:38"),
                    PrintJob(owner: "g3anna@", rank: "3", size: "266874", time: "14:03:38"),
                    PrintJob(owner: "g3anna@", rank: "4", size: "221583", time: "14:03:38"),
                    PrintJob(owner: "g5nagee@", rank: "5", size: "1183837", time: "14:06:12")
                ]),
            Printer(name: "P3185a", description: "Redirected to P3175a in BA3175",
                jobs: [
                    PrintJob(owner: "g5q@", rank: "done", size: "853311", time: "12:07:32")
                ]),
            Printer(name: "P3175a", description: "Kyocera Network Printer in BA3175",
                jobs: [
                    PrintJob(owner: "g5q@", rank: "done", size: "853311", time: "12:07:32")
                ])
        ]
        
        self.loadContentView()
        
        self.pushViewController(contentViewController!, animated: false)
        
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

        if NSUserDefaults.standardUserDefaults().isFirstPrintersLaunch() {
            PopupView.showFirstPrintersLaunchPopup()
        }
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
        self.refreshControl?.addTarget(self,
                                       action: #selector(self.refresh(_:) as UIRefreshControl -> Void),
                                       forControlEvents: .ValueChanged)
        self.tableView?.addSubview(refreshControl!)
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printerData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return PrinterTableViewCell(printer: self.printerData[indexPath.row])
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let printerViewController = PrinterViewController(printer: self.printerData[indexPath.row], row: indexPath.row)
        self.pushViewController(printerViewController, animated: true)
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
                    let printers = json["printers"] as! [[String:AnyObject]]
                    
                    for printer in printers {
                        var name = printer["name"] as! String
                        name = name.titleCaseString
                        
                        let rawJobs = printer["jobs"] as! [[String:String]]
                        var jobs: [PrintJob] = []
                        for job in rawJobs {
                            jobs.append(PrintJob(
                                    owner: job["owner"]!,
                                    rank: job["rank"]!,
                                    size: job["size"]!,
                                    time: job["time"]!))
                        }
                        
                        let description = printer["description"] as! String
                        
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

    func refresh(row: Int) -> [PrintJob] {
        self.refresh(self.refreshControl!)
        return self.printerData[row].jobs
    }
}
