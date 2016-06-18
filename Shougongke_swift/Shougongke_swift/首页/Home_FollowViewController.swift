//
//  Home_FollowViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
class Home_FollowViewController: BaseViewController {

    override func loadView()
    {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = VCHeight
        self.tableView?.frame = view.frame
        YYLogs(self.classForCoder)
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
