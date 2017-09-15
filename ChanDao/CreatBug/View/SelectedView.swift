//
//  SelectedView.swift
//  ChanDao
//
//  Created by libowen on 2017/9/14.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 功能：自定义一个selected view，供复用
 1、包含titleLabel、detailLabel、imageView
 
 */

import UIKit

enum SubviewType {
    case input
    case tapLabel
}

class SelectedView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // property
    var backView: UIView!
    var title: UILabel!
    var detail: UILabel!
    var imageView: UIImageView!
    var inputTextFeild: UITextField!
    var subviewType: SubviewType!
    
    init(_ type:SubviewType, titleText:String, placeholder:String) {
        super.init(frame: CGRect())
        
        subviewType = type
        setUpUI()
        title.text = titleText
        if type == .tapLabel {
            detail.text = placeholder
        } else {
            inputTextFeild.placeholder = placeholder
        }
        // 如果是.tapLabel线上图片，否则不显示
        imageView.image = type == .tapLabel ? UIImage(named: "actionbutton") : nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setUpUI() {
        // add backView
        backView = UIView()
        backView.backgroundColor = UIColor.white
        self.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
        
        // add title
        title = UILabel()
        backView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        title.topAnchor.constraint(equalTo: backView.topAnchor, constant: 13).isActive = true
        title.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -13).isActive = true
        title.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // add icon
        imageView = UIImageView()
        backView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -8).isActive = true
        imageView.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        if subviewType == SubviewType.tapLabel {
            /// .tapLabel
            
            // add detail
            detail = UILabel()
            backView.addSubview(detail)
            detail.translatesAutoresizingMaskIntoConstraints = false
            detail.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8).isActive = true
            detail.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
            detail.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
            detail.setContentHuggingPriority(250, for: .horizontal)
            detail.setContentHuggingPriority(250, for: .vertical)
        } else {
            /// .input
            
            // add inputTextFeild
            inputTextFeild = UITextField()
            backView.addSubview(inputTextFeild)
            inputTextFeild.translatesAutoresizingMaskIntoConstraints = false
            inputTextFeild.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8).isActive = true
            inputTextFeild.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
            inputTextFeild.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
        }
        
        // add seperator
        let seperator = UIView()
        seperator.backgroundColor = UIColor.gray
        backView.addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        seperator.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 0).isActive = true
        seperator.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

}
