//
//  SectionHeaderView.swift
//  ChanDao
//
//  Created by owen on 17/7/8.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    static let id = "SectionHeader"
    
    /// 自定义UI
    let title: UILabel = {
        let title = UILabel()
        title.frame = CGRect(x: 20, y: 10, width: 200, height: 30)
        return title
    }()
    
    /// 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /// data model variable
    var screeningTag: ScreeningTag? {
        didSet {
            title.text = screeningTag?.name
        }
    }
    
    /// 事件处理clsure
        
}
