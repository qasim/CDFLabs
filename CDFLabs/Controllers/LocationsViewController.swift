//
//  LocationsViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class LocationsViewController: UINavigationController {

    var contentViewController: UIViewController?
    
    override func loadView() {
        super.loadView()

        self.loadContentView()
        self.pushViewController(contentViewController!, animated: false)
    }
    
    func loadContentView() {
        self.contentViewController = UIViewController()
        self.contentViewController!.title = "Locations"
    }
}