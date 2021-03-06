//
//  AppDelegate.swift
//  GoogleSearchJSON
//
//  Created by englieh on 28/8/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var searchResults:SearchResults=SearchResults()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tb:UITabBarController = window?.rootViewController as! UITabBarController
        let toViewController0:GoogleSearchViewController =
        tb.viewControllers![0] as! GoogleSearchViewController;
        toViewController0.searchResults = self.searchResults;
        
        let navController = (tb.viewControllers![1] as! UINavigationController)
        
        let toViewController1:GoogleResultsViewController =
        navController.childViewControllers[0] as! GoogleResultsViewController
        
        toViewController1.searchResults = self.searchResults;
        
        let toViewController2:GoogleResultWebViewController =
        tb.viewControllers![2] as! GoogleResultWebViewController
        toViewController2.searchResults = self.searchResults;
        
        // Add your two observers here.
        
        return true
    }
    
    func switchWebView() {
        let tb:UITabBarController =
        window?.rootViewController as! UITabBarController
        let fromView:UIView = tb.selectedViewController!.view;
        let toView:UIView! = tb.viewControllers?[2].view;
        
        // Transition using a page curl.
        UIView.transition(from: fromView, to:toView,duration:0.5,
        options: UIViewAnimationOptions.transitionCurlDown,
        completion:{(finished:Bool)-> Void in
        if (finished) {
            tb.selectedIndex = 2;
        }}
        );
    }
    
    func switchResultView() {
        let tb:UITabBarController =
        window?.rootViewController as! UITabBarController
        let fromView:UIView = tb.selectedViewController!.view;
        let toView:UIView! = tb.viewControllers?[1].view;
        
        // Transition using a page curl.
        UIView.transition(from: fromView, to:toView,duration:0.5, options: UIViewAnimationOptions.transitionCurlDown,completion:{(finished:Bool)-> Void in
            if (finished) {
                tb.selectedIndex = 1;
            }});
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        }
        
        func applicationDidEnterBackground(_ application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }
        
        func applicationWillEnterForeground(_ application: UIApplication) {
            // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        }
        
        func applicationDidBecomeActive(_ application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }
        
        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
        
        
}

