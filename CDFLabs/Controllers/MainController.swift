//
//  MainController.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/28/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
    
    override func loadView() {
        super.loadView()
        
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor.cdfBlueColor()
        self.tabBar.translucent = false
        self.tabBar.setValue(true, forKey: "_hidesShadow")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
