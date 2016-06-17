//
//  ViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {


    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "UI更新"

        self.tableView?.headerView = YYRefreshGifHeader.addRefreshHeaderWithRrefreshingBlock({
            self.loadData()
        })

    }
    func loadData() {
        print("asdfalsjdfljsd")
        self.tableView?.headerView?.endRefreshing()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }

    func getText(row:Int) -> String
    {
        switch (row % 5)
        {
        case 0:
            return "这是一行文字"
        case 1:
            return "这里是两行文字\n两行"
        case 2:
            return "这里三行文字\n第二行\n第三行"
        case 3:
            return "不知道会是多少行，手机屏幕宽度不同可能行数不同"
        case 4:
            return "这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行,这里是大量的文字，但是只会显示前四行"
        default:
            break
        }
        return ""
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if 0 == indexPath.row
        {
            let cell = createCell(defaultCell)
            cell.bindByTag("titleLabel", data: "我是第(\(indexPath.row)行Title)")
            cell.bindByTag(7002, data: "我是第(\(indexPath.row)行DetailText)")
            return cell
        }
        else
        {
            let cell = createCell("customCell")
            cell.bindByTag("multLineText", data: getText(indexPath.row))
            return cell
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if 0 == indexPath.row
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
        else
        {
            let cell = createCacheCell("customCell")
            cell.bindByTag("multLineText", data: getText(indexPath.row))

            var frame = cell.frame
            frame.size.width = tableView.frame.size.width
            cell.frame = frame
            cell.spUpdateLayout()
            cell.calcHeight()
            return cell.frame.size.height;
        }
    }


    func TabButtonAction(button:UIButton)
    {
        for(var i=0; i<4; i+=1)
        {
            let otherButton = button.superview?.viewWithTag(8001+i)
            (otherButton as? UIButton)?.selected = false
            otherButton?.viewWithTag(1001)?.hidden = true
        }
        button.selected = true
        button.viewWithTag(1001)?.hidden = false
    }

    func AlterLabelText(button:UIButton)
    {
        button.selected = !button.selected
        if let label = self.tableView?.tableHeaderView?.viewWithStrTag("contentText") as? UILabel
        {
            if button.selected
            {
                label.text = "这里的文字是自动计算大小"
            }
            else
            {
                label.text = "这里的文字是自动计算大小, 并且父view也是可以根据文字自动计算大小，无需代码计算"
            }
            UIView.beginAnimations(nil, context: nil)
            resetTableHeaderView(self.tableView?.tableHeaderView)
            UIView.commitAnimations()
        }
    }


}

