//
//  ProductViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/20.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ProductViewController: BaseViewController {

    override func loadView()
    {
        super.loadView()
        let headerView = skinParser?.parse("tableHeaderView")
        resetTableHeaderView(headerView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.frame = CGRectMake(0, 64, AppWidth, AppHeight-64-50)

        // Do any additional setup after loading the view.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 || section == 1 {
            return 1
        }
        return 10;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.section==0 {
            let cell = createCell(defaultCell)
            cell.bindByTag("titleLabel1", data: "我是第(\(indexPath.row)行Title)")
            cell.bindByTag("titleLabel2", data: "我是第(\(indexPath.row)行DetailText)")
            cell.bindByTag("titleLabel3", data: "我是第(\(indexPath.row)行DetailText)")
            return cell
        }
        else if(indexPath.section==1) {
            let cell = createCell("SelectCell")
            return cell
        }
        else {
            let cell = createCell("customCell")
            cell.bindByTag("titleLabel", data: "我是第(\(indexPath.row)行Title)")
            cell.bindByTag(7002, data: "我是第(\(indexPath.row)行DetailText)")
            return cell
        }

    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headview = createCell("headSectionView")
        if section==0 {
            headview.bindByTag("selectlab", data: "每日特价")
            return headview
        }
        else if(section==1) {
            headview.bindByTag("selectlab", data: "精选专题")
            return headview
        }
        return nil
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 40
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section==0 {
            let cell = createCacheCell(defaultCell)
            cell.bindByTag("titleLabel1", data: "我是第(\(indexPath.row)行Title)")
            cell.bindByTag("titleLabel2", data: "我是第(\(indexPath.row)行DetailText)")
            cell.bindByTag("titleLabel3", data: "我是第(\(indexPath.row)行DetailText)")
            var frame = cell.frame
            frame.size.width = tableView.frame.size.width
            cell.frame = frame
            cell.spUpdateLayout()
            cell.calcHeight()
            return cell.frame.size.height;
        }
        else if(indexPath.section==1)   {
            let cell = createCell("SelectCell")
            var frame = cell.frame
            frame.size.width = tableView.frame.size.width
            cell.frame = frame
            cell.spUpdateLayout()
            cell.calcHeight()
            return cell.frame.size.height;
        }
        else {
            let cell = createCacheCell("customCell")
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

    //表头随着tableView一起滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let sectionHeaderHeight: CGFloat = 40
        if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
        else if scrollView.contentOffset.y >= sectionHeaderHeight {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
