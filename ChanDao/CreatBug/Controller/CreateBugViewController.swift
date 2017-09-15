//
//  CreateBugViewController.swift
//  ChanDao
//
//  Created by libowen on 2017/9/14.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 功能：创建bug页面
 1、scrollView作为页面主体，使屏幕显示不开时可滚动，backContent作为scrollView的content view；选择项目复用；标题和步骤使用label+textView；附件使用scrollView+imageView
 2、
 */

import UIKit

class CreateBugViewController: UIViewController {
    
    // property
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.backgroundColor = UIColor.gray
        return scrollView
    }()
    var backView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        //stackView.spacing = 50
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("CreateBugViewController: viewDidLoad")
        
        creatUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 创建UI
    private func creatUI() {
        
        // add scrollView
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // add backView
        scrollView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        // 注意：不加此约束，scrollView显示不正常
        backView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        //backView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        
        // add a test view
        let view1 = SelectedView(.tapLabel, titleText: "title1", placeholder: "detail1")
        backView.addArrangedSubview(view1)
        view1.translatesAutoresizingMaskIntoConstraints = false
        
        let view2 = SelectedView(.input, titleText: "title2", placeholder: "detail2")
        backView.addArrangedSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        
        // 
        //let view3 = SelectedView(.tapLabel, titleText: "title3", placeholder: "placeholder3")
//        let view3 = UIView()
//        view3.backgroundColor = UIColor.white
//        scrollView.addSubview(view3)
//        view3.translatesAutoresizingMaskIntoConstraints = false
//        view3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
//        view3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
//        view3.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
//        view3.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
//        view3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        view3.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        //view3.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        //view3.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0).isActive = true
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
