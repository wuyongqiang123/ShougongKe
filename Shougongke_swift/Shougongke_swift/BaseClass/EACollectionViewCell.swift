//
//  EACollectionViewCell.swift
//  Shougongke_swift
//
//  Created by 永强 on 16/6/20.
//  Copyright © 2016年 wyq. All rights reserved.
//

import UIKit

class EACollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.spUpdateLayout()
    }

}
