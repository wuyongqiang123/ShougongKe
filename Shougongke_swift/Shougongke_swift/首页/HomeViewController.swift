//
//  HomeViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    //选择的哪个vc
    var selectIdex: Int? = 0
    //保存起来防止重复生成VC
    var childVCs = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"

        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false
        var style = SegmentStyle()
        // 标题不滚动, 则每个label会平分宽度
        style.scrollTitle = false
        // 滚动条
        style.showLine = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 滚动条颜色
        style.scrollLineColor = UIColor.redColor()

        let titles = setChildVcs().map { $0.title! }

        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: AppWidth, height: AppHeight - 64-50), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        scroll.ScrollPageBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            YYLogs(index)
            self.selectIdex = index
        }
        view.addSubview(scroll)

    }
    override func freshSkin() {

        let vc = self.setChildVcs()[self.selectIdex!] as! BaseViewController
        YYLogs(vc)
        vc.freshSkin()
    }

    func setChildVcs() -> [UIViewController] {
        if(0 == childVCs.count)
        {
            let vc1 = Home_SelectedViewController()
            vc1.title = "精选"

            let vc2 = Home_FollowViewController()
            vc2.title = "关注"

            let vc3 = Home_MasterViewController()
            vc3.title = "达人"

            let vc4 = Home_ActivityViewController()
            vc4.title = "活动"

            childVCs = [vc1, vc2, vc3,vc4]
        }
        return childVCs;
    }

}
