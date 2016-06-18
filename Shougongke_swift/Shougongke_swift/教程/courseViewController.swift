//
//  courseViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
import Alamofire
class courseViewController: BaseViewController {

    var menuView: YYMenuView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "教程"

        menuView = YYMenuView.init(frame: CGRectMake(0, 64, AppWidth, 40))
        menuView!.deselectColor = UIColor.darkGrayColor()
        menuView!.configureView(["全部分类","一周","最新更新"])
        self.view.addSubview(menuView!)
        getArrData()
    }

    func getArrData() {

        YYNetworkTools.dataRequest(YYNetworkTools.Method.GET, urlString: SGKApiKeyCourseCategory, parameter: nil) { (responseObject, error) in
            print("JSON: \(responseObject)")
            let status =  responseObject!["status"] as! Int
            if  status == 1 {
                let array: [AnyObject] = CourseCategory.mj_objectArrayWithKeyValuesArray(responseObject!["data"]) as [AnyObject]
                print(array)
                self.menuView!.setCategoryArray(array)
            }
        }

    }

}
