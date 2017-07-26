//
//  RankingTableViewCell.swift
//  Network
//
//  Created by libowen on 2017/7/6.
//  Copyright © 2017年 libowen. All rights reserved.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    
    /// 定义UI: 三个label用于显示数据
    let rankLabel: UILabel = {
        let rankLabel: UILabel = UILabel()
        return rankLabel
    }()
    let nameLabel: UILabel = {
        let nameLable: UILabel = UILabel()
        nameLable.numberOfLines = 0
        return nameLable
    }()
    let totalCountLabel: UILabel = {
        let totalCountLabel: UILabel = UILabel()
        return totalCountLabel
    }()
    
    /// 初始化
    func setUpCell() {
        
        self.contentView.addSubview(rankLabel)
        rankLabel.textColor = UIColor.black
        rankLabel.backgroundColor = UIColor.gray
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(totalCountLabel)
        totalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        rankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        rankLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        rankLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        
        totalCountLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        totalCountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: totalCountLabel.trailingAnchor, constant: 10).isActive = true
        totalCountLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpCell()
        //fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// data model variable
    var ranking: RankingModel? {
        didSet {
            self.rankLabel.text = ranking?.rank
        }
    }
    
    /// 事件处理clsure

}
