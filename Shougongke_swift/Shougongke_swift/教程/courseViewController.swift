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

    lazy var menuView: YYMenuView? = {
        let menu = YYMenuView.init(frame: CGRectMake(0, 64, AppWidth, 40))
        menu.deselectColor = UIColor.darkGrayColor()
        return menu
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "教程"
        self.menuView!.configureView(["全部分类","一周","最新更新"])
        self.view.addSubview(self.menuView!)
        getArrData()
    }

    func getArrData() {

        Alamofire.request(.GET, SGKApiKeyCourseCategory, parameters:nil)
            .responseJSON { response in

                let json = response.result.value

                if (json != nil) {
                    print("JSON: \(json)")
                    let status =  json!["status"] as! Int
                    if  status == 1 {
                        let array: [AnyObject] = CourseCategory.mj_objectArrayWithKeyValuesArray(json!["data"]) as [AnyObject]
                        print(array)
                        self.menuView!.setCategoryArray(array)
                    }
                }
        }
    }

}
