//
//  LocationsViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit
import KLCPopup

class LocationsViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {

    var contentViewController: UIViewController?
    var tableView: UITableView?
    
    var popupView: InfoPopupView?
    var popup: KLCPopup?
    
    override func loadView() {
        super.loadView()

        self.loadContentView()
        self.pushViewController(contentViewController!, animated: false)
        
        let infoButton = UIButton(type: .InfoLight)
        infoButton.tintColor = UIColor.whiteColor()
        infoButton.addTarget(self, action: "info", forControlEvents: .TouchUpInside)
        let infoBarButton = UIBarButtonItem(customView: infoButton)
        self.contentViewController!.navigationItem.leftBarButtonItem = infoBarButton
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Locations"
        
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
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return BahenLocationViewCell()
        } else {
            return NXLocationViewCell()
        }
    }
    
    func info() {
        if self.popup == nil {
            self.popupView = InfoPopupView()
            self.popup = KLCPopup(contentView: self.popupView!)
        }
        self.popup?.show()
    }
}
