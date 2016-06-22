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
        menu.SelectIndexBlock({ (itemIndex, cellIndex) in
            print("\(itemIndex),\(cellIndex)")
        })
        menu.deselectColor = UIColor.darkGrayColor()
        return menu
    }()
    var colltionView: UICollectionView?
    private var number:[Int] = []

   
    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = VCHeight
        self.menuView!.configureView(["全部分类","一周","最新更新"])
        self.view.addSubview(self.menuView!)

        for i in 0...15 {
            number.append(i)
        }
        let layout = UICollectionViewFlowLayout()
        colltionView = UICollectionView(frame: CGRectMake(0, (self.menuView?.bottom)!, AppWidth, view.height), collectionViewLayout: layout)
        //注册一个cell
        colltionView!.registerClass(ImageTextCell.self, forCellWithReuseIdentifier:"ImageTextCell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;

        colltionView?.backgroundColor = UIColor.whiteColor()
        //设置每一个cell的宽高
        layout.itemSize = CGSizeMake((AppWidth-30)/2, 200)
        self.view .addSubview(colltionView!)

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

extension ImageTextViewController:UICollectionViewDataSource,UICollectionViewDelegate  {

    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 1
    }
    //返回多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 15
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageTextCell", forIndexPath: indexPath) as! ImageTextCell


        cell.titleLabel!.text = "不织布"
        cell.titleName?.text = "by 刘丽姨liay"
        cell.titleOther?.text = "0人气 / 0收嚐"


        return cell
    }
    
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        

    }

}
