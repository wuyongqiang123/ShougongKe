//
//  AppDelegate.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = UINavigationController.init(rootViewController: ViewController())
        self.window!.makeKeyAndVisible()
        // Override point for customization after application launch.
        //firstStart不为空,不是是第一次启动
        if  NSUserDefaults.standardUserDefaults().objectForKey("FirstStart") != nil {

            setupTabViewController()
        }else {
            //是第一次启动
            NSUserDefaults.standardUserDefaults().setObject(false, forKey: "FirstStart")
            let firstVC = WelcomeViewController()

            self.window?.rootViewController = firstVC
        }
        enableSkinDebug()

        return true
    }

    func setupTabViewController() {

        let rootVC = RootTabBarController()

        self.window?.rootViewController = rootVC
        
        
    }

    func enableSkinDebug()
    {
        #if DEBUG
            let debugWin = EADebugWindow.createDebugWindow()
            debugWin.hidden = false
            #if arch(i386) || arch(x86_64)
                debugWin.setSkinPath("Resources",absolutePath:#file)
            #endif
        #endif
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

