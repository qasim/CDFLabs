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
    
    var labData: [Lab]?
    var tableView: UITableView?
    
    override func loadView() {
        super.loadView()
        
        self.navigationBar.translucent = false
        
        self.loadContentView()
        self.pushViewController(self.contentViewController!, animated: false)
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Computers"
        
        self.labData = []
        
        self.loadTableView()
        
        /*let contentView = self.contentViewController!.view
        
        self.loadSortSegmentedControl()
        contentView.addSubview(sortSegmentedControl!)
        
        let viewsDict: [String: AnyObject] = [
            "sortSegmentedControl": self.sortSegmentedControl!
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-[sortSegmentedControl]-|", options: .AlignAllLeft, metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[sortSegmentedControl]", options: .AlignAllTop, metrics: nil, views: viewsDict))*/
        
    }
    
    func loadTableView() {
        self.tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labData!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
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
