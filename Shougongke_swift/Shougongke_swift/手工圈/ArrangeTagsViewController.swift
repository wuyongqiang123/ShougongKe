//
//  ArrangeTagsViewController.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/19.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit



class ArrangeTagsViewController: UIViewController {

    var colltionView: UICollectionView?
    private var numbers: [Int] = []
    private var number:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...100 {
            numbers.append(i)
        }

        for i in 0...10 {
            number.append(i)
        }

        let layout = UICollectionViewFlowLayout()
        colltionView = UICollectionView(frame: CGRectMake(0, 0, AppWidth, AppHeight), collectionViewLayout: layout)
        //注册一个cell
        colltionView!.registerClass(ArrangeTagsCell.self, forCellWithReuseIdentifier:"cell")
        //注册一个headView
        colltionView! .registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;

        colltionView?.backgroundColor = UIColor.whiteColor()
        //设置每一个cell的宽高
        layout.itemSize = CGSizeMake((AppWidth-50)/4, 30)
        self.view .addSubview(colltionView!)
    }

}

extension ArrangeTagsViewController:UICollectionViewDataSource,UICollectionViewDelegate {

    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return 2
    }
    //返回多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section==0 {
            return number.count
        }
        return numbers.count
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ArrangeTagsCell
        if indexPath.section==0 {
            cell.titleLabel!.text = String.init(number[indexPath.row])
        }
        else {
            cell.titleLabel!.text = String.init(numbers[indexPath.row])
        }

        return cell
    }
    //返回HeadView的宽高
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: AppWidth, height: 40)
    }

    //返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
        let headerTag = 1314520
        let header = colltionView!.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headView", forIndexPath: indexPath)
        let lb = UILabel(frame: CGRectMake(9, 14, header.width - 18, 15))
        lb.tag = headerTag
        lb.font = UIFont.systemFontOfSize(28)
        lb.textColor = UIColor.blackColor()
        lb.text = indexPath.section == 0 ? "已选择标签": "标记出你的兴趣"
        header.addSubview(lb)

        return header
    }
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {



        if indexPath.section==0 {
            //先修改数据源
            let str = number[indexPath.row]
            number.removeAtIndex(indexPath.row)
            numbers.insert(str, atIndex: 0)
            //再修改cell的indexPath(如果先于数据源修改，就会报错)
            collectionView.performBatchUpdates({
                collectionView.moveItemAtIndexPath(indexPath, toIndexPath: NSIndexPath.init(forRow: 0, inSection: 1))
                }, completion: { ( finished) in

            })

        }
        else {
            //先修改数据源
            let str = numbers[indexPath.row]
            numbers.removeAtIndex(indexPath.row)
            number.insert(str, atIndex: 0)
            //再修改cell的indexPath(如果先于数据源修改，就会报错)
            collectionView.performBatchUpdates({
                collectionView.moveItemAtIndexPath(indexPath, toIndexPath: NSIndexPath.init(forRow: self.number.count-1, inSection: 0))
                }, completion: { ( finished) in

            })
        }
        collectionView.reloadData()
    }
}
