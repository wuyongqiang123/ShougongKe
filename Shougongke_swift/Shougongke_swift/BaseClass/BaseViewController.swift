//
//  BaseViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
import Foundation
public let defaultCell = "defaultCell"
class BaseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    internal var skinParser : SkinParser?
    var tableView: UITableView?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        self.automaticallyAdjustsScrollViewInsets = false
        skinParser = SkinParser.getParserByName(NSStringFromClass(self.classForCoder))
        skinParser?.eventTarget = self

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func loadView()
    {
        super.loadView()
        skinParser?.parse("selfView", view:self.view)

        tableView = UITableView.init(frame: CGRectMake(0,0, AppWidth, AppHeight), style: UITableViewStyle.Plain)
        // 设置tableView的数据源
        tableView!.dataSource = self
        // 设置tableView的委托
        tableView!.delegate = self
        tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView!)

    }
    override func viewDidLoad()
    {   super.viewDidLoad()
//        self.view.backgroundColor = UIColor.clearColor()
        self.view.spUpdateLayout()


    }
    func resetTableHeaderView(tableHeaderView:UIView?) {
        let rect: CGRect = self.view.frame
        tableHeaderView!.frame = rect
        tableHeaderView?.spUpdateLayout()
        tableHeaderView?.calcHeight()
        tableView?.tableHeaderView = nil
        tableView?.tableHeaderView = tableHeaderView
        
    }
    func createCell(identifier:String)->UITableViewCell {
        return createCell(identifier, nil)
    }

    func createCell(identifier:String, _ created:((UITableViewCell)->Void)?)->UITableViewCell{
        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier)
        if(cell == nil){
            cell = EATableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier);
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            skinParser?.parse(identifier, view: cell);
            if created != nil {
                created!(cell!)
            }
        }
        return cell!;
    }

    lazy var cacheViews = Dictionary<String, UIView>()
    func createCacheCell(identifier:String)->UITableViewCell{

        let dentifier_cache = identifier+"_cache"
        var cacheView = cacheViews[dentifier_cache] as? UITableViewCell

        if nil == cacheView {
            cacheView = tableView?.dequeueReusableCellWithIdentifier(dentifier_cache)
            if nil == cacheView {
                cacheView = EATableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: dentifier_cache)
                skinParser?.parse(identifier, view: cacheView)
            }
            cacheView!.selectionStyle = UITableViewCellSelectionStyle.None
            cacheViews[dentifier_cache] = cacheView
        }
        return cacheView!
    }

    func createCell(parser : SkinParser?,identifier:String) -> UITableViewCell
    {
        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier)
        if (cell == nil)
        {
            cell = EATableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
            parser?.parse(identifier, view: cell!)
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.createCell(defaultCell)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (skinParser?.valueWithName("self", key: "numberOfRowsInSection\(section)") as? Int ?? 0)
    }


    #if DEBUG
    func freshSkin()
    {
        tableView = nil
    #if (arch(x86_64) || arch(i386))

    self.view = UIView()
    skinParser = SkinParser.getParserByName( NSStringFromClass(self.classForCoder))
    loadView()
    viewDidLoad()

    #else
    //真机上调试界面
    #endif

    }
    #endif

}
