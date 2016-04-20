//
//  PrinterViewController.swift
//  CDFLabs
//
//  Created by Qasim on 2016-04-01.
//  Copyright © 2016 Qasim Iqbal. All rights reserved.
//

import UIKit
import Just
import KLCPopup

class PrinterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var refreshControl: UIRefreshControl?
    var refreshButton: UIBarButtonItem?

    var printer: Printer?
    var row: Int = 0

    var printjobData: [PrintJob] = []
    var tableView: UITableView?

    init(printer: Printer, row: Int) {
        super.init(nibName: nil, bundle: nil)

        self.printer = printer
        self.row = row

        self.printjobData = printer.jobs
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        super.loadView()

        self.loadContentView()

        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = printer?.name

        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self,
                                             action: #selector(self.refresh as Void -> Void))
        self.navigationItem.rightBarButtonItem = self.refreshButton!
    }

    func loadContentView() {
        self.loadTableView()
        self.view.addSubview(self.tableView!)

        let viewsDict: [String: AnyObject] = [
            "tableView": self.tableView!
        ]

        let options = NSLayoutFormatOptions(rawValue: 0)

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|[tableView]|", options: options, metrics: nil, views: viewsDict))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[tableView]|", options: options, metrics: nil, views: viewsDict))
    }

    func loadTableView() {
        self.tableView = CLTableView()
        self.tableView?.estimatedRowHeight = CLTable.printerCellHeight
        self.tableView?.rowHeight = UITableViewAutomaticDimension

        self.tableView?.delegate = self
        self.tableView?.dataSource = self

        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)),
                                       forControlEvents: .ValueChanged)
        self.tableView?.addSubview(refreshControl!)

        self.tableView?.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return printjobData.count
    }

    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return PrinterJobViewCell(job: self.printjobData[indexPath.row])
    }

    func tableView(tableView: UITableView,
                   heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CLTable.cellHeight + CLTable.cellPadding + 6
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
        let printersViewController = self.navigationController as? PrintersViewController
        let printjobData = printersViewController!.refresh(self.row)

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.printjobData = printjobData
            self.tableView?.reloadData()
        })
        refreshControl.endRefreshing()
        CATransaction.commit()
    }
}
