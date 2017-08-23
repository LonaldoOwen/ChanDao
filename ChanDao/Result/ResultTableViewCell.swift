//
//  ResultTableViewCell.swift
//  ChanDao
//
//  Created by libowen on 2017/8/21.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 说明：使用Xib自定义cell
 注意：1、IBOutlet是连在File's Owner上还是cell上，前者需要在cell文件中load Xib文件才能使用，后者在tableView中注册Xib就可使用了；
      2、
 */

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    /// 定义UI
    @IBOutlet weak var developer: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var project: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var totalNum: UILabel!
    
    
    /// 初始化

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// data model variable
    var resultModel: ResultModel? {
        didSet {
            self.developer.text = resultModel?.developer
            self.product.text = resultModel?.product
            self.project.text = resultModel?.project
            self.level.text = resultModel?.level
            self.totalNum.text = resultModel?.totalCount
        }
    }
    
    /// 事件处理clsure
    
}
