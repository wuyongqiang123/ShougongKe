//
//  ImageTextViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/19.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class ImageTextViewController: UIViewController {

    lazy var menuView: YYMenuView? = {
        let menu = YYMenuView.init(frame: CGRectMake(0, 64, AppWidth, 40))
        menu.deselectColor = UIColor.darkGrayColor()
        return menu
    }()
//    var colltionView: UICollectionView?
    private var number:[Int] = []
    override func loadView()
    {
        super.loadView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.frame = VCHeight
        self.menuView!.configureView(["全部分类","一周","最新更新"])
        self.view.addSubview(self.menuView!)

        for i in 0...8 {
            number.append(i)
        }
//        self.colltionView?.frame = CGRectMake(0, (self.menuView?.bottom)!, AppWidth, view.height-self.menuView!.height)
//        //设置每一个cell的宽高
//        self.layout!.itemSize = CGSizeMake((AppWidth-30)/2, 100)

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

//extension ImageTextViewController  {
//
//    //返回多少个cell
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return number.count
//    }
//    //返回自定义的cell
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//
//        let cell = createCell(defaultColltionCell, indexPath: indexPath)
//        cell.bindByTag("titleLabel", data: "我是第(\(indexPath.row)行Title)")
//        cell.bindByTag(7002, data: "我是第(\(indexPath.row)行DetailText)")
//        return cell
//    }
//    //返回cell 上下左右的间距
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
//        return UIEdgeInsetsMake(5, 10, 5, 10)
//    }
//
//     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//        let cell = createCell(defaultColltionCell,indexPath: indexPath)
//        cell.bindByTag("titleLabel", data: "我是第\(indexPath.row)行Title")
//        cell.bindByTag(7002, data: "我是第\(indexPath.row)行DetailText")
//        var frame = cell.frame
//        frame.size.width = colltionView!.frame.size.width
//        cell.frame = frame
//        cell.spUpdateLayout()
//        cell.calcHeight()
//        return CGSizeMake(cell.width, cell.height)
//    }
//
//}
