//
//  UIViewController+Swizzle.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/21.
//  Copyright © 2016年 wyq. All rights reserved.
//  交换方法，实现自己的

import UIKit

extension UIViewController {


       override public class func initialize() {

        struct Static {
            static var token: dispatch_once_t = 0
        }

        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }

        dispatch_once(&Static.token) {
            //交换系统的方法
            Swizzle(UIViewController.self, origSEL: #selector(UIViewController.viewDidAppear(_:)), newSEL: #selector(UIViewController.customViewDidAppear(_:)))
            Swizzle(UIViewController.self, origSEL: #selector(UIViewController.viewWillAppear(_:)), newSEL: #selector(UIViewController.customviewWillAppear(_:)))
            //这个交换方法不行，还在找原因-------------_________-----------
            Swizzle(UIViewController.self, origSEL:Selector("deinit"), newSEL: #selector(UIViewController.new_deinit))
        }//deinit
    }

    func customViewDidAppear(animated: Bool) {
        //print("class = %@", NSStringFromClass(self.classForCoder))
        if NSStringFromClass(self.classForCoder).hasSuffix("_RootViewController") {
            self.rdv_tabBarController.setTabBarHidden(false, animated: true)
            print("setTabBarHidden:NO --- customViewDidAppear : %@", NSStringFromClass(self.classForCoder))
        }
        self.customViewDidAppear(animated)
    }

    func customviewWillAppear(animated: Bool) {
        //print("class-count = %lu", self.navigationController?.childViewControllers.count)
        if self.navigationController?.childViewControllers.count > 1 {
            self.rdv_tabBarController.setTabBarHidden(true, animated: true)
            print("setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass(self.classForCoder))
        }
        self.customviewWillAppear(animated)
    }

    func new_deinit() {
        let message: String = "[标题:\(self.title)],[类:\(NSStringFromClass(self.classForCoder))]"
        if UIDevice.isSimulator() {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(1.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                KGStatusBar.dismiss()
            })
            KGStatusBar.showWithStatus(message)
            self.new_deinit()
            return
        }
        print("deinit %@", message)
        self.new_deinit()
    }
}


