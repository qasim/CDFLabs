//
//  ComputersViewController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class ComputersViewController: UINavigationController {

    var viewController: UIViewController?
    
    override func loadView() {
        super.loadView()
        self.navigationBar.translucent = false
        
        self.viewController = UIViewController()
        self.viewController!.title = "Computers"
        
        self.pushViewController(viewController!, animated: false)
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
