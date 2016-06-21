//
//  BaseColltionViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/20.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit
public let defaultColltionCell = "defaultColltionCell"
class BaseColltionViewController: UIViewController {


    //选择的哪个vc
    var selectIdex: Int? = 0
    //保存起来防止重复生成VC
    var childVCs = [UIViewController]()
    internal var skinParser : SkinParser?
    var colltionView: UICollectionView?
    var layout: UICollectionViewFlowLayout?
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

        layout = UICollectionViewFlowLayout()
        colltionView = UICollectionView(frame: CGRectMake(0,0, AppWidth,AppHeight), collectionViewLayout:layout!)
        //注册一个cell
        colltionView!.registerClass(EACollectionViewCell.self, forCellWithReuseIdentifier:defaultColltionCell)
        colltionView?.delegate = self;
        colltionView?.dataSource = self;

        colltionView?.backgroundColor = UIColor.whiteColor()
        //设置每一个cell的宽高
        layout!.itemSize = CGSizeMake(AppWidth, 100)
        self.view.addSubview(colltionView!)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.spUpdateLayout()
        // Do any additional setup after loading the view.
    }

    func createCell(identifier:String,indexPath: NSIndexPath)->UICollectionViewCell {
        return createColltionCell(identifier,indexPath: indexPath)
    }
    func createColltionCell(identifier:String,indexPath:NSIndexPath)->UICollectionViewCell{
        let cell = colltionView?.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        skinParser?.parse(identifier, view: cell)

        return cell!
    }

    func createCell(parser : SkinParser?,identifier:String,indexPath:NSIndexPath) -> UICollectionViewCell
    {
        let cell = colltionView?.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        parser?.parse(identifier, view: cell!)

        return cell!
    }

    #if DEBUG
    func freshSkin()
    {
        colltionView = nil
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

extension BaseColltionViewController:UICollectionViewDataSource,UICollectionViewDelegate {


    /**
     - returns: Section中Item的个数
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = createCell(defaultColltionCell, indexPath: indexPath)

        return cell
    }
    /**
     Description:可以定制不同的item

     - returns: item的大小
     */
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//         //return (skinParser?.valueWithName("self", key: "sizeForItemAtIndexPath\(indexPath)") as? CGSize ?? CGSizeMake(0, 0))
//    }

}
