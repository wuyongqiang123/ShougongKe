//
//  Home_SelectedViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class Home_SelectedViewController: BaseViewController {

    var anotherBanner: BannerPageViewController?
    override func loadView()
    {
        super.loadView()
        let headerView = skinParser?.parse("tableHeaderView")
        let BannerPageView = headerView?.viewWithStrTag("Banner")
        bannerView(BannerPageView!)
        resetTableHeaderView(headerView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = VCHeight
        self.tableView?.frame = view.frame
        //下拉刷新
        self.tableView?.headerView = YYRefreshGifHeader.addRefreshHeaderWithRrefreshingBlock({

        })
    }
    //图片轮播
    func bannerView(view: UIView) {
        anotherBanner = BannerPageViewController()

        if let bannerViewController = anotherBanner {
            view.addSubview(bannerViewController.view)
            bannerViewController.view.frame = view.frame

            bannerViewController.interval = 3
            
            bannerViewController.placeholderImage = UIImage(named: "placeholder")

            bannerViewController.setRemoteImageFetche({ (imageView, url, placeHolderImage) -> Void in
                imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: placeHolderImage)
            })

            bannerViewController.images = [
                "https://cdn-ifnotalk-com.alikunlun.com/images/3/cd/cbf38bc67d58fb61c42a14f6b468c.jpg",
                UIImage(named: "reindeer-1"),
                UIImage(named: "reindeer-2")
            ]
            bannerViewController.setBannerTapHandler({ (index) -> Void in
                print("banner with index \(index) tapped.")
            })
            
            bannerViewController.startRolling()
        }
    }

   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = createCell(defaultCell)
        cell.bindByTag("titleLabel", data: "我是第(\(indexPath.row)行Title)")
        cell.bindByTag(7002, data: "我是第(\(indexPath.row)行DetailText)")
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cell = createCacheCell(defaultCell)
        cell.bindByTag("titleLabel", data: "我是第\(indexPath.row)行Title")
        cell.bindByTag(7002, data: "我是第\(indexPath.row)行DetailText")
        var frame = cell.frame
        frame.size.width = tableView.frame.size.width
        cell.frame = frame
        cell.spUpdateLayout()
        cell.calcHeight()
        return cell.frame.size.height;
    }


}
