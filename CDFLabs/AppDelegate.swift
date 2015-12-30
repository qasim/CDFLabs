//
//  AppDelegate.swift
//  CDFLabs
//
//  Created by Qasim Iqbal on 12/19/15.
//  Copyright © 2015 Qasim Iqbal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainController: MainController?
    
    var computersViewController: ComputersViewController?
    var printersViewController: PrintersViewController?
    var locationsViewController: LocationsViewController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.mainController = MainController()
        
        // View initialization
        self.computersViewController = ComputersViewController()
        self.printersViewController = PrintersViewController()
        self.locationsViewController = LocationsViewController()
        self.mainController?.viewControllers = [
            self.computersViewController!,
            self.printersViewController!,
            self.locationsViewController!
        ]
        
        // Tab bar item styling
        let tabBarItemAppearance = UITabBarItem.appearance()
        tabBarItemAppearance.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.cdfDisabledBlueColor()], forState: .Normal)
        tabBarItemAppearance.setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.whiteColor()], forState: .Selected)
        
        // Tab bar item creation
        let computerIcon = UIImage(named: "ComputerIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        let computerSelectedIcon = UIImage(named: "ComputerSelectedIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        self.computersViewController!.tabBarItem = UITabBarItem(title: "Computers", image: computerIcon, tag: 0)
        self.computersViewController!.tabBarItem.selectedImage = computerSelectedIcon
        
        let printerIcon = UIImage(named: "PrinterIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        let printerSelectedIcon = UIImage(named:"PrinterSelectedIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        self.printersViewController!.tabBarItem = UITabBarItem(title: "Printers", image: printerIcon, tag: 1)
        self.printersViewController!.tabBarItem.selectedImage = printerSelectedIcon
        
        let locationIcon = UIImage(named: "LocationIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        let locationSelectedIcon = UIImage(named:"LocationSelectedIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        self.locationsViewController!.tabBarItem = UITabBarItem(
            title: "Locations", image: locationIcon, tag: 2)
        self.locationsViewController!.tabBarItem.selectedImage = locationSelectedIcon
        
        self.mainController?.selectedIndex = 0
        
        // Navigation bar styling
        let navigationAppearance = UINavigationBar.appearance()
        navigationAppearance.barStyle = UIBarStyle.Default
        navigationAppearance.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.whiteColor() ]
        navigationAppearance.barTintColor = UIColor.cdfBlueColor()
        navigationAppearance.setBackgroundImage(UIImage(), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        navigationAppearance.shadowImage = UIImage()
        
        // Window styling
        application.statusBarStyle = UIStatusBarStyle.LightContent
        self.window?.backgroundColor = UIColor.cdfGreyColor()
        self.window?.rootViewController = self.mainController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

