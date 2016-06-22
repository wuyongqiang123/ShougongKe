//
//  YYMenuView.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/16.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit


typealias YYMenuSelectIndexBlock = (itemIndex: NSInteger,cellIndex: NSInteger)->()

class YYMenuView: UIView {

    var selectBlock: YYMenuSelectIndexBlock = {_,_ in }
    func SelectIndexBlock(block:YYMenuSelectIndexBlock) {
        self.selectBlock = block
    }
    //懒加载
    lazy var selectedColor: UIColor? = {
        let color = UIColor.redColor()
        return color
    }()
    lazy var deselectColor: UIColor? = {
        let color = UIColor.blackColor()
        return color
    }()
    var menuDataArray: [AnyObject] = []
    var collectionDataArray: [AnyObject] = []
    var menuItemArray: [AnyObject] = []
    lazy var flowLayout: UICollectionViewFlowLayout? = {
        let flowlaout = UICollectionViewFlowLayout()
        flowlaout.minimumInteritemSpacing = 0
        flowlaout.minimumLineSpacing = 0
        return flowlaout
    }()

    lazy var collectionView: UICollectionView? = {
        let collView = UICollectionView.init(frame: CGRectMake(0, (self.itemContainerView?.top)!, AppWidth, 0), collectionViewLayout: self.flowLayout!)
        collView.backgroundColor = CollectionViewBgColor
        collView.dataSource = self
        collView.delegate = self
        collView.registerClass(YYMenuCollectionViewCell.self, forCellWithReuseIdentifier: dyMenuCollectionCellIdentifier)
        return collView
    }()

    lazy var itemContainerView: UIView? = {
        let itemView = UIView.init(frame: CGRectMake(0, 0, AppWidth, 40))
        itemView.backgroundColor = ItemBgColor
        itemView.layer.borderWidth = 0.5
        itemView.layer.borderColor = UIColor.clearColor().CGColor
        return itemView
    }()
    lazy var backgroundView: UIView? = {
        let back = UIView.init(frame: CGRectMake(0, 0, AppWidth, AppHeight))
        back.backgroundColor = UIColor.clearColor()
        back.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(YYMenuView.takeBackCollectionView))
        back.addGestureRecognizer(tap)
        return back
    }()
    lazy var bottomBtn: UIButton? = {
        let btn = UIButton.init(type: UIButtonType.Custom)
        btn.frame = CGRectMake(0, self.collectionView!.bottom, AppWidth, 40)
        btn.backgroundColor = ItemBgColor
        btn.setImage(UIImage.init(named: "dymenu_selected"), forState:.Normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(10,0,0,0)
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        btn.addTarget(self, action: #selector(YYMenuView.takeBackCollectionView), forControlEvents: .TouchUpInside)
        return btn
    }()
    var currentItem: YYMenuItem?


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.backgroundView!)
        self.addSubview(self.collectionView!)
        self.addSubview(self.bottomBtn!)
        self.addSubview(self.itemContainerView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //初始化头部view
    func configureView(DataArray: [AnyObject]) {
        self.menuDataArray = DataArray

        for i in 0..<self.menuDataArray.count {

            let item: YYMenuItem = YYMenuItem()
            item.frame = CGRectMake(CGFloat(i) * ((AppWidth-10)/3), 0, (AppWidth-10)/3, 40)
            item.tag = i + MenuItemTagAdd
            item.selectedIndex = 0
            item.titleLabel!.font = UIFont.systemFontOfSize(14, weight:UIFontWeightThin)
            item.setTitleColor(self.deselectColor, forState: .Normal)
            item.setTitleColor(self.selectedColor, forState: .Selected)
            item.setImage(UIImage(named: "dymenu_normal"), forState: .Normal)
            item.setImage(UIImage(named: "dymenu_selected"), forState: .Selected)
            item.addTarget(self, action: #selector(YYMenuView.ClickAction(_:)), forControlEvents: .TouchUpInside)
//            var model: YYMenuDataModel = self.menuDataArray[i][0]
//            item.setTitle(model.title, forState: .Normal)
            let string = self.menuDataArray[i] as! String
            item.setTitle(string, forState: .Normal)
            self.menuItemArray.append(item)
            self.itemContainerView!.addSubview(item)

            let line = UILabel.init(frame: CGRectMake(item.right+10, 5, 1, 30))
            line.backgroundColor = UIColor.lightGrayColor()
            self.itemContainerView!.addSubview(line)


        }


    }
    //点击事件
    func ClickAction(sender: YYMenuItem) {
        let index = sender.tag - MenuItemTagAdd
        for i in 0..<self.menuItemArray.count {
            let item = self.menuItemArray[i] as! YYMenuItem
            if item == sender {
                item.selected = !item.selected
                self.currentItem = item
            }
            else{
                item.selected = false
            }
        }

        if sender.selected {
            self.collectionDataArray = self.menuDataArray[index] as! [AnyObject]
            YYLogs(self.collectionDataArray)
            let collectionViewHeight: CGFloat = CGFloat(self.collectionDataArray.count) * CGFloat(MenuCellHeight)
            let collectionViewHeight2: CGFloat = self.collectionDataArray.count % 2 == 1 ? CGFloat((self.collectionDataArray.count / 2 + 1)) * CGFloat(MenuCellHeight) : CGFloat(self.collectionDataArray.count / 2) * CGFloat(MenuCellHeight)
            if collectionViewHeight < AppHeight * 0.6 {
                self.expandWithCollectionViewHeight(collectionViewHeight, cellNumOfRow: 1)
            }
            else if collectionViewHeight2 > AppHeight * 0.6 {
                self.expandWithCollectionViewHeight(AppHeight * 0.6, cellNumOfRow: 2)
            }
            else {
                self.expandWithCollectionViewHeight(collectionViewHeight2, cellNumOfRow: 2)
            }

        }
        else {
            self.takeBackCollectionView()
        }

    }

    //展开。
    func expandWithCollectionViewHeight(collectionViewHeight: CGFloat, cellNumOfRow: Int) {
        //CGFloat(cellNumOfRow)
        self.flowLayout!.itemSize = CGSizeMake(AppWidth / CGFloat(cellNumOfRow), 40)

        self.height = AppHeight
        self.bottomBtn?.height = 40
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.backgroundView!.backgroundColor = UIColor.clearColor()
        })

        self.collectionView?.height = collectionViewHeight
        self.collectionView?.top = (self.itemContainerView?.top)!+40
        self.bottomBtn?.top = (self.collectionView?.bottom)!

        self.collectionView!.reloadData()
    }

    //收起。
    func takeBackCollectionView() {
        self.currentItem!.selected = false
        self.collectionView?.height = 0
        self.collectionView?.top = (self.itemContainerView?.top)!
        self.bottomBtn?.top = (self.collectionView?.bottom)!
        self.bottomBtn?.height = 0
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.backgroundView!.backgroundColor = UIColor.clearColor()
            }, completion: {(finished: Bool) -> Void in
                self.height = 40
        })
    }
    //设置数据
    func setCategoryArray(categoryArr: [AnyObject]) {
        self.menuDataArray = self.getMenuDataArray(categoryArr)
        self.collectionView?.reloadData()
    }
    //分割数据
     func getMenuDataArray(categoryArr: [AnyObject]) -> [AnyObject] {
        let model: YYMenuDataModel = YYMenuDataModel.init(title: "全部分类", name: "sgk_course_cate_all", url: "")
        //(title: "全部分类", imgName: "sgk_course_cate_all", imgUrl: nil)
        var categorys: [AnyObject] = [model]
        for i in 0..<categoryArr.count {
            let category: CourseCategory = categoryArr[i] as! CourseCategory
            let model: YYMenuDataModel = YYMenuDataModel.init(title: category.cate_name!, name: "", url: category.cate_ico!)
            categorys.append(model)
        }
        let model0: YYMenuDataModel = YYMenuDataModel.init(title: "一周", name: "sgk_course_time_week", url: "")
        let model1: YYMenuDataModel = YYMenuDataModel.init(title: "一月", name: "sgk_course_time_month", url: "")
        let model2: YYMenuDataModel = YYMenuDataModel.init(title: "全部教程", name: "sgk_course_time_all", url: "")
        let timeArr: [AnyObject] = [model0, model1, model2]
        let model10: YYMenuDataModel = YYMenuDataModel.init(title: "最新更新", name: "sgk_course_sort_new", url: "")
        let model11: YYMenuDataModel = YYMenuDataModel.init(title: "最热教程", name: "sgk_course_sort_hot", url: "")
        let model12: YYMenuDataModel = YYMenuDataModel.init(title: "评论最多", name: "sgk_course_sort_comment", url: "")
        let model13: YYMenuDataModel = YYMenuDataModel.init(title: "收藏最多", name: "sgk_course_sort_collect", url: "")
        let model14: YYMenuDataModel = YYMenuDataModel.init(title: "材料包有售", name: "sgk_course_sort_material", url: "")
        let model15: YYMenuDataModel = YYMenuDataModel.init(title: "成品有售", name: "sgk_course_sort_product", url: "")
        let sortArr: [AnyObject] = [model10, model11, model12, model13, model14, model15]
        return [categorys, timeArr, sortArr]
    }




}
//collectionView代理方法
extension YYMenuView:UICollectionViewDelegate,UICollectionViewDataSource {


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        YYLogs(self.collectionDataArray.count)
        return self.collectionDataArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell: YYMenuCollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(dyMenuCollectionCellIdentifier, forIndexPath: indexPath) as! YYMenuCollectionViewCell)
        let model: YYMenuDataModel = self.collectionDataArray[indexPath.row] as! YYMenuDataModel
        cell.configuraCellWith(model)
        if self.currentItem!.selectedIndex == indexPath.row {
            cell.title_lab!.textColor = self.selectedColor
        }
        else {
            cell.title_lab!.textColor = self.deselectColor
        }
        return cell

    }
    //点击item方法

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        self.currentItem!.selectedIndex = indexPath.row
        let model: YYMenuDataModel = self.collectionDataArray[indexPath.row] as! YYMenuDataModel
        self.currentItem!.setTitle(model.titles, forState: .Normal)
        self.selectBlock(itemIndex: self.currentItem!.tag - MenuItemTagAdd, cellIndex: self.currentItem!.selectedIndex!)
        YYLogs(model.titles)
        self.takeBackCollectionView()
    }

}
