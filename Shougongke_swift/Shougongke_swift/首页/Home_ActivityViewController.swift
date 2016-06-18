//
//  Home_ActivityViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class Home_ActivityViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = VCHeight
        self.tableView?.frame = view.frame
        //下拉刷新
        self.tableView?.headerView = YYRefreshGifHeader.addRefreshHeaderWithRrefreshingBlock({

        })
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = createCell(defaultCell)
        cell.bindByTag("titleLabel", data: "花大娘")
        cell.bindByTag(7002, data: "51图文教程|0视频教程|344手工图")
        return cell
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let cell = createCacheCell(defaultCell)
        cell.bindByTag("titleLabel", data: "花大娘")
        cell.bindByTag(7002, data: "51图文教程|0视频教程|344手工图")
        var frame = cell.frame
        frame.size.width = tableView.frame.size.width
        cell.frame = frame
        cell.spUpdateLayout()
        cell.calcHeight()
        return cell.frame.size.height;
    }
    
}
