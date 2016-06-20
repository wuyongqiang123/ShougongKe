//
//  BaseViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/15.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
public let defaultCell = "defaultCell"
class BaseViewController: UIViewController {

    //选择的哪个vc
    var selectIdex: Int? = 0
    //保存起来防止重复生成VC
    var childVCs = [UIViewController]()
    internal var skinParser : SkinParser?
    var tableView: UITableView?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        skinParser = SkinParser.getParserByName(NSStringFromClass(self.classForCoder))
        skinParser?.eventTarget = self

    }
    //tabbar点击事件
    func tabBarItemClicked() {

    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func loadView()
    {
        super.loadView()
        skinParser?.parse("selfView", view:self.view)
        tableView = self.skinParser?.parse("tableView") as? UITableView

        if (tableView != nil) {
            self.view.addSubview(tableView!)
        }
        tableView!.dataSource = self
        // 设置tableView的委托
        tableView!.delegate = self
//        tableView = UITableView.init(frame:self.view.bounds, style: UITableViewStyle.Plain)
//        // 设置tableView的数据源
//        tableView!.dataSource = self
//        // 设置tableView的委托
//        tableView!.delegate = self
//        tableView!.separatorStyle = UITableViewCellSeparatorStyle.None
//        self.view.addSubview(tableView!)

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
        var ipfile: String = NSBundle.mainBundle().resourcePath.stringByAppendingString("/ip")
        var ipstr: String = String.stringWithContentsOfFile(ipfile, encoding: (error as! NSUTF8StringEncoding), error: nil)
        ipstr = ipstr.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\n "))
        var filepath: String = ipstr.stringByAppendingFormat(":8000/%@.json", NSStringFromClass(self.self))
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {() -> Void in
            var url: NSURL = NSURL(string: "http://\(filepath)")!
            var request: NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestReloadIgnoringLocalCacheData, timeoutInterval: 10)
            var received: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            dispatch_async(dispatch_get_main_queue(), {() -> Void in
                var skinParser: SkinParser = SkinParser.getParserByData(received)
                if skinParser != nil {
                    self.skinParser = skinParser
                    self.loadView()
                    self.viewDidLoad()
                }
                for childViewControler: BaseViewController in self.childViewControllers {
                    if (childViewControler is BaseViewController.self) {
                        childViewControler.freshSkin()
                    }
                }
            })
        })

    #endif

    }
    #endif

}

extension BaseViewController:UITableViewDataSource,UITableViewDelegate {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return self.createCell(defaultCell)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (skinParser?.valueWithName("self", key: "numberOfRowsInSection\(section)") as? Int ?? 0)
    }

}
