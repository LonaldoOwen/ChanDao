//
//  ScreeningCell.swift
//  ChanDao
//
//  Created by owen on 17/7/8.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class ScreeningCell: UICollectionViewCell {
    
    /// 自定义UI
    let title: UILabel = {
        let title = UILabel()
        return title
    }()
    
    /// 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 1.0
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// data model variable
    var screeningTag: ScreeningTag? {
        didSet {
            self.title.text = screeningTag?.name
        }
    }
    
    /// 事件处理clsure
    
}
