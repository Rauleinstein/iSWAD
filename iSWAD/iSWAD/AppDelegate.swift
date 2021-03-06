//
//  AppDelegate.swift
//  iSWAD
//
//  Created by Raul Alvarez on 16/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import UIKit
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
	let defaults = NSUserDefaults.standardUserDefaults()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		
		
		let defaults = NSUserDefaults.standardUserDefaults()
		
		let reachability: Reachability
		do {
			reachability = try Reachability.reachabilityForInternetConnection()
		} catch {
			print("Unable to create Reachability")
			return false
		}
		
		if !reachability.isReachable() {
			defaults.setObject(nil, forKey: Constants.wsKey)
		}
		
		if (defaults.stringForKey(Constants.wsKey) == nil || defaults.stringForKey(Constants.wsKey) == "") {
			self.window?.rootViewController?.performSegueWithIdentifier("showLogin", sender: self)
		} else {
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewControllerWithIdentifier("CoursesView") as! UISplitViewController
			let navigationController = vc.viewControllers[vc.viewControllers.count-1] as! UINavigationController
			navigationController.topViewController!.navigationItem.leftBarButtonItem = vc.displayModeButtonItem()
			
			self.window?.rootViewController = vc
			
			let rightNavController = vc.viewControllers.last as! UINavigationController
			let detailViewController = rightNavController.topViewController as! CoursesDetailViewController
			let leftNavController = vc.viewControllers.first as! UINavigationController
			let masterViewController = leftNavController.topViewController as! CoursesMasterViewController
			masterViewController.getCourses()
			sleep(1)
			let firstCourse = masterViewController.coursesList.first
			detailViewController.detailItem = firstCourse
			detailViewController.configureView()
			
		}

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
		defaults.setBool(false, forKey: Constants.logged)
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
		
		guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
		guard let topAsDetailController = secondaryAsNavController.topViewController as? CoursesDetailViewController else { return false }
		if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
		    return true
		}
		return false
    }

}

