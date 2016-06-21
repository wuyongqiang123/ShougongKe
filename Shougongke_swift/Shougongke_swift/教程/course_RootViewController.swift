//
//  courseViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
class course_RootViewController: BaseViewController {


    var topView: ScrollSegmentView!
    var contentView: ContentView!
    var ImageText = ImageTextViewController()
    let Video = VideoViewController()
    func getArrData() {

        YYNetworkTools.dataRequest(YYNetworkTools.Method.GET, urlString: SGKApiKeyCourseCategory, parameter: nil) {[unowned self] (responseObject, error) in

            if (responseObject != nil) {
                print("JSON: \(responseObject)")
                let status =  responseObject!["status"] as! Int
                if  status == 1 {
                    let array: [AnyObject] = CourseCategory.mj_objectArrayWithKeyValuesArray(responseObject!["data"]) as [AnyObject]
                    print(array)
                    self.ImageText.menuView!.setCategoryArray(array)
                    self.Video.menuView!.setCategoryArray(array)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false

        var style = SegmentStyle()

        // 标题不滚动, 则每个label会平分宽度
        style.scrollTitle = false
        style.titleLine = true
        style.titleBigScale = 1.0
        style.gradualChangeTitleColor = true
        // title正常状态颜色 使用RGB空间值
        style.normalTitleColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.0)
        //        // title选中状态颜色 使用RGB空间值
        style.selectedTitleColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        let titles = setChildVcs().map { (childVc) -> String in
            childVc.title!
        }

        topView = ScrollSegmentView(frame: CGRect(x: 0, y: 0, width: 150, height: 28), segmentStyle: style, titles: titles)
        
        contentView = ContentView(frame: view.bounds, childVcs: setChildVcs(), parentViewController: self)
        contentView.delegate = self // 必须实现代理方法

        topView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            self.contentView.setContentOffSet(CGPoint(x: self.contentView.bounds.size.width * CGFloat(index), y: 0), animated: true)

        }
        


        navigationItem.titleView = topView
        view.addSubview(contentView)

        getArrData()
    }

    // 设置childVcs
    func setChildVcs()  -> [UIViewController]{
        if(0 == childVCs.count) {
            let vc1 = ImageText
            vc1.view.backgroundColor = UIColor.whiteColor()
            vc1.title = "图文"

            let vc2 = Video
            vc2.view.backgroundColor = UIColor.whiteColor()
            vc2.title = "视频"

            let vc3 = SpecialViewController()
            vc3.view.backgroundColor = UIColor.whiteColor()
            vc3.title = "专题"
            childVCs = [vc1, vc2,vc3]
        }
        return childVCs
    }

    override func freshSkin() {

//        let vc = self.setChildVcs()[self.selectIdex!] as! BaseViewController
//        YYLogs(vc)
//        vc.freshSkin()
    }
}

extension course_RootViewController: ContentViewDelegate {
    var segmentView: ScrollSegmentView {
        return topView
    }
    func contentViewDidEndMoveToIndex(currentIndex: Int) {

        self.selectIdex = currentIndex
    }
}
