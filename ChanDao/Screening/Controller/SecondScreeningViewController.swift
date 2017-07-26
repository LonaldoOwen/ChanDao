//
//  SecondScreeningViewController.swift
//  ChanDao
//
//  Created by libowen on 2017/7/25.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class SecondScreeningViewController: UIViewController {
    
    ///
    var bugLevelView: ItemView!
    var productView: ItemView!
    var projectView: ItemView!
    var developerView: ItemView!
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 
//        let itemView = ItemView(frame: CGRect(x: 20, y: 100, width: 300, height: 50))
//        view.addSubview(itemView)
//        itemView.titleText.text = "chanpin"
//        itemView.valueText.text = "chanpin_name"
        
        view.backgroundColor = UIColor.white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)

//        contentView.addSubview(bugLevelView)
//        contentView.addSubview(productView)
//        contentView.addSubview(projectView)
//        contentView.addSubview(developerView)
        
        //layoutUI()
        addItemViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //layoutUI()
    }
    
    override func viewWillLayoutSubviews() {
        layoutUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ///
    func layoutUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 0).isActive = true
    }
    
    func addItemViews() {
        let width = UIScreen.main.bounds.width - 20
        bugLevelView = ItemView()
        bugLevelView.frame = CGRect(x: 10, y: 20, width: width, height: 50)
        bugLevelView.titleText.text = "bug级别"
        contentView.addSubview(bugLevelView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizier))
        bugLevelView.addGestureRecognizer(tapGestureRecognizer)
        
        productView = ItemView()
        productView.frame = CGRect(x: 10, y: 80, width: width, height: 50)
        productView.titleText.text = "产品"
        contentView.addSubview(productView)
        
        projectView = ItemView()
        projectView.frame = CGRect(x: 10, y: 150, width: width, height: 50)
        projectView.titleText.text = "项目"
        contentView.addSubview(projectView)
        
        developerView = ItemView()
        developerView.frame = CGRect(x: 10, y: 220, width: width, height: 50)
        developerView.titleText.text = "开发人员"
        contentView.addSubview(developerView)
        
    }
    
    @objc func handleTapGestureRecognizier(_ sender: UIGestureRecognizer) {
        print("tap")
        // show PickerView
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
