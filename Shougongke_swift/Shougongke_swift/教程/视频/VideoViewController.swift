//
//  VideoViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/19.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class VideoViewController: BaseViewController {

    lazy var menuView: YYMenuView? = {
        let menu = YYMenuView.init(frame: CGRectMake(0, 64, AppWidth, 40))
        menu.SelectIndexBlock({ (itemIndex, cellIndex) in
            print("\(itemIndex),\(cellIndex)")
        })
        menu.deselectColor = UIColor.darkGrayColor()
        return menu
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = VCHeight
        
        self.menuView!.configureView(["全部分类","一周","最新更新"])
        self.view.addSubview(self.menuView!)
        self.tableView?.frame =  CGRectMake(0, (self.menuView?.bottom)!, AppWidth, view.height)

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
