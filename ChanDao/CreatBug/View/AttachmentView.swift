//
//  AttachmentView.swift
//  ChanDao
//
//  Created by libowen on 2017/9/19.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class AttachmentView: UIView {
    
    // property
    var backView: UIView = {
        let backView = UIView()
        return backView
    }()
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    var contentView: UIStackView = {
        let contentView = UIStackView()
        contentView.axis = .horizontal
        contentView.alignment = .fill
        contentView.distribution = .equalSpacing
        contentView.spacing = 20
        return contentView
    }()
    
    var addImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.orange
        let image = Helper.resize(image: UIImage(named: "加号")!, bySize: CGSize(width: 40, height: 40))
        imageView.image = image
        imageView.contentMode = .center
        return imageView
    }()
    
    var tapAddImageHandler: (() -> Void)!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 创建UI
    func createUI() {
        
        self.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
        backView.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.lightGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15).isActive = true
        scrollView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 15).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20).isActive = true
        
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15).isActive = true
        contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        
        contentView.addArrangedSubview(addImageView)
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAddImageView)))
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    
    // add imageView
    func handleAddImageView() {
        print("Handle add imageView")
        
        // 调用closure
        self.tapAddImageHandler()
        
        // 插入图像
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        // 插入imageView
        contentView.insertArrangedSubview(imageView, at: contentView.arrangedSubviews.count - 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        contentView.layoutIfNeeded()
    }

    // 设置图片
    func setImage(_ image: UIImage) {
        let imageView: UIImageView = contentView.subviews.last as! UIImageView
        imageView.image = image
    }
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
