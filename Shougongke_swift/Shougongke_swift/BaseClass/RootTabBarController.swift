//
//  RootTabBarController.swift
//  Beibei
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class RootTabBarController: RDVTabBarController,RDVTabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatSubViewControllers()
    }
    func creatSubViewControllers(){

        let home  = Home_RootViewController()
        let nav_home = BaseNavigationController.init(rootViewController: home)


        let course = course_RootViewController()
        let nav_course = BaseNavigationController.init(rootViewController: course)

        let handring = HandRing_RootViewController()
        let nav_handring = BaseNavigationController.init(rootViewController: handring)

        let market = Market_RootViewController()
        let nav_market = BaseNavigationController.init(rootViewController: market)

        let My = My_RootViewController()
        let nav_my = BaseNavigationController.init(rootViewController: My)

        self.tabBar.setHeight(50)
        self.viewControllers = [nav_home,nav_course,nav_handring,nav_market,nav_my]
        customizeTabBarForController()
        self.delegate = self

    }

    func customizeTabBarForController() {

        let backgroundImage: UIImage = UIImage.init(named: "tabbar_background")!
        let tabBarItemImages: NSArray = ["YY_tab_home","YY_tab_course","YY_tab_zone","YY_tab_sales", "YY_tab_personal"];
        let tabBarItemTitles: NSArray = ["首页", "教程", "手工圈", "市集", "我的"];
        var index = 0

        for i in 0 ..< 5 {
            let item: RDVTabBarItem = (self.tabBar.items as AnyObject).objectAtIndex(i) as! RDVTabBarItem
            item.setBackgroundSelectedImage(backgroundImage, withUnselectedImage: backgroundImage)
            let simage  = tabBarItemImages.objectAtIndex(index) as! String
            let selectedimage = UIImage.init(named:"\(simage)_selected")
            let uimage = tabBarItemImages.objectAtIndex(index) as! String
            let unselectedimage = UIImage.init(named:"\(uimage)_normal")
            item.setFinishedSelectedImage(selectedimage, withFinishedUnselectedImage: unselectedimage)
            item.title = tabBarItemTitles.objectAtIndex(index) as! String
            item.selectedTitleAttributes =  [NSForegroundColorAttributeName: UIColor.redColor(),NSFontAttributeName: UIFont(name: "Heiti SC", size: 12.0)!]
            item.unselectedTitleAttributes = [NSForegroundColorAttributeName: UIColor.blackColor(),NSFontAttributeName: UIFont(name: "Heiti SC", size: 12.0)!]
            index += 1
        }
    }
//    func tabBarController(tabBarController: RDVTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
//        if tabBarController.selectedViewController != viewController {
//            return true
//        }
//        if !(viewController.isKindOfClass(UINavigationController)) {
//            return true
//        }
//        let nav: UINavigationController = (viewController as! UINavigationController)
//        if nav.topViewController != nav.viewControllers[0] {
//            return true
//        }
//        else {
//            if (nav.topViewController!.isKindOfClass(BaseViewController)) {
//                let rootVC: BaseViewController = (nav.topViewController as! BaseViewController)
//                rootVC.tabBarItemClicked()
//            }
//        }
//        return true
//    }

    func tabBarController(tabBarController: RDVTabBarController!, didSelectViewController viewController: UIViewController!) {
        if tabBarController.selectedViewController != viewController {
            return
        }
        let nav: UINavigationController = (viewController as! UINavigationController)
        if nav.topViewController != nav.viewControllers[0] {
            return 
        }
        else {
            if (nav.topViewController!.isKindOfClass(BaseViewController)) {
                let rootVC: BaseViewController = (nav.topViewController as! BaseViewController)
                rootVC.tabBarItemClicked()
            }
        }
    }

}
