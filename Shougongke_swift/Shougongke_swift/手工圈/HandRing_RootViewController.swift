//
//  HandRingViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class HandRing_RootViewController: BaseViewController {

    var scrollPageView: ScrollPageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "手工圈"
        // 这个是必要的设置
        automaticallyAdjustsScrollViewInsets = false

        var style = SegmentStyle()
        // 滚动条
        style.showLine = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 滚动条颜色
        style.scrollLineColor = UIColor.redColor()

        /// 显示附加按钮
        style.showExtraButton = true

        /// 设置附加按钮的背景图片
        style.extraBtnBackgroundImageName = "plus.png"

        // 设置初始数据
        let titles = setChildVcs().map{ $0.title! }

        scrollPageView = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        scrollPageView.ScrollPageBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            YYLogs(index)
            self.selectIdex = index
        }
        scrollPageView.extraBtnOnClick = {[unowned self] (extraBtn: UIButton) in
            KGStatusBar.showWithStatus("你说的啥跟傻")
            let arrange = ArrangeTagsViewController()
            self.navigationController?.pushViewController(arrange, animated: true)
        }
        view.addSubview(scrollPageView)
    }

    func setChildVcs() -> [UIViewController] {
        if childVCs.count==0 {
            let vc1 = UIViewController()
            vc1.title = "国内头条"
            let vc2 = UIViewController()
            vc2.view.backgroundColor = UIColor.greenColor()
            vc2.title = "国际要闻"

            let vc3 = UIViewController()
            vc3.view.backgroundColor = UIColor.redColor()
            vc3.title = "趣事"

            let vc4 = UIViewController()
            vc4.view.backgroundColor = UIColor.yellowColor()
            vc4.title = "囧图"

            let vc5 = UIViewController()
            vc5.view.backgroundColor = UIColor.lightGrayColor()
            vc5.title = "明星八卦"

            let vc6 = UIViewController()
            vc6.view.backgroundColor = UIColor.brownColor()
            vc6.title = "爱车"

            let vc7 = UIViewController()
            vc7.view.backgroundColor = UIColor.orangeColor()
            vc7.title = "国防要事"

            let vc8 = UIViewController()
            vc8.view.backgroundColor = UIColor.blueColor()
            vc8.title = "科技频道"

            let vc9 = UIViewController()
            vc9.view.backgroundColor = UIColor.brownColor()
            vc9.title = "手机专页"

            let vc10 = UIViewController()
            vc10.view.backgroundColor = UIColor.orangeColor()
            vc10.title = "风景图"
            
            let vc11 = UIViewController()
            vc11.view.backgroundColor = UIColor.blueColor()
            vc11.title = "段子"

            childVCs = [vc1, vc2, vc3,vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11]
        }

        return childVCs
    }


    override func tabBarItemClicked() {
        print("akfjskdjfksjdlkfjaksjdfkl")
        //let login = LoginViewController()
       // self.navigationController?.pushViewController(login, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
