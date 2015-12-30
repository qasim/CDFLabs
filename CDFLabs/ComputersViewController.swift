//
//  ComputersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class ComputersViewController: UINavigationController {

    var contentViewController: UIViewController?
    var sortSegmentedControl: UISegmentedControl?
    
    override func loadView() {
        super.loadView()
        
        self.navigationBar.translucent = false
        
        self.loadContentView()
        self.pushViewController(self.contentViewController!, animated: false)
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Computers"
        
        let contentView = self.contentViewController!.view
        
        self.loadSortSegmentedControl()
        contentView.addSubview(sortSegmentedControl!)
        
        let viewsDict: [String: AnyObject] = [
            "sortSegmentedControl": self.sortSegmentedControl!
        ]
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-[sortSegmentedControl]-|", options: .AlignAllLeft, metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-16-[sortSegmentedControl]", options: .AlignAllTop, metrics: nil, views: viewsDict))
        
    }
    
    func loadSortSegmentedControl() {
        self.sortSegmentedControl = UISegmentedControl(items: ["Availability", "Name"])
        self.sortSegmentedControl?.translatesAutoresizingMaskIntoConstraints = false
        self.sortSegmentedControl?.tintColor = UIColor.cdfBlueColor()
        self.sortSegmentedControl?.selectedSegmentIndex = 0
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
