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
    //var attachmentContent: UIStackView!
    
    var attachmentView: AttachmentView = {
        let attachmentView = AttachmentView()
        return attachmentView
    }()
    
    let selectName = ["产品", "项目", "模块", "版本", "指派", "严重程度"]
    var selectViews: [SelectedView] = []

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
        
        // add scrollView（VC可滚动）
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.setContentHuggingPriority(250, for: .horizontal)
        scrollView.setContentHuggingPriority(250, for: .vertical)
        
        
        // add backView（使用stackview）
        scrollView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        backView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        backView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        backView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        // 注意：不加此约束，scrollView显示不正常
        backView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        //backView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        backView.setContentHuggingPriority(250, for: .horizontal)
        backView.setContentHuggingPriority(250, for: .vertical)

        
        // add selected view（可选择的view的集合）
        for (index, item) in selectName.enumerated() {
            
            let selectedView = SelectedView(.tapLabel, titleText: item, placeholder: "选择" + item)
            backView.addArrangedSubview(selectedView)
            selectViews.append(selectedView)
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            selectedView.tapDetailHandler = { [weak self] in
                self?.showPickerVC(index)
            }
            
        }
        
        
        // add title view（标题）
        let titleBackView = UIView()
        backView.addArrangedSubview(titleBackView)
        //titleBackView.backgroundColor = UIColor.lightGray
        titleBackView.translatesAutoresizingMaskIntoConstraints = false
        titleBackView.setContentHuggingPriority(250, for: .horizontal)
        titleBackView.setContentHuggingPriority(250, for: .vertical)
        
        let title = UILabel()
        titleBackView.addSubview(title)
        title.text = "标题"
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: titleBackView.leadingAnchor, constant: 15).isActive = true
        title.trailingAnchor.constraint(equalTo: titleBackView.trailingAnchor, constant: -15).isActive = true
        title.topAnchor.constraint(equalTo: titleBackView.topAnchor, constant: 20).isActive = true
        
        let titleInput = UITextView()
        titleBackView.addSubview(titleInput)
        titleInput.text = "input..."
        titleInput.backgroundColor = UIColor.lightGray
        titleInput.translatesAutoresizingMaskIntoConstraints = false
        titleInput.leadingAnchor.constraint(equalTo: titleBackView.leadingAnchor, constant: 15).isActive = true
        titleInput.trailingAnchor.constraint(equalTo: titleBackView.trailingAnchor, constant: -15).isActive = true
        titleInput.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10).isActive = true
        titleInput.bottomAnchor.constraint(equalTo: titleBackView.bottomAnchor, constant: -10).isActive = true
        titleInput.heightAnchor.constraint(equalToConstant: 88).isActive = true
        titleInput.setContentHuggingPriority(250, for: .horizontal)
        titleInput.setContentHuggingPriority(250, for: .vertical)
        
        
        // add step view (编辑)
        let stepBackView = UIView()
        backView.addArrangedSubview(stepBackView)
        //stepBackView.backgroundColor = UIColor.lightGray
        stepBackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stepTitle = UILabel()
        stepBackView.addSubview(stepTitle)
        stepTitle.text = "步骤"
        stepTitle.translatesAutoresizingMaskIntoConstraints = false
        stepTitle.leadingAnchor.constraint(equalTo: stepBackView.leadingAnchor, constant: 15).isActive = true
        stepTitle.trailingAnchor.constraint(equalTo: stepBackView.trailingAnchor, constant: -15).isActive = true
        stepTitle.topAnchor.constraint(equalTo: stepBackView.topAnchor, constant: 20).isActive = true
        
        let stepInput = UITextView()
        stepBackView.addSubview(stepInput)
        stepInput.backgroundColor = UIColor.lightGray
        stepInput.translatesAutoresizingMaskIntoConstraints = false
        stepInput.leadingAnchor.constraint(equalTo: stepBackView.leadingAnchor, constant: 15).isActive = true
        stepInput.trailingAnchor.constraint(equalTo: stepBackView.trailingAnchor, constant: -15).isActive = true
        stepInput.topAnchor.constraint(equalTo: stepTitle.bottomAnchor, constant: 10).isActive = true
        stepInput.bottomAnchor.constraint(equalTo: stepBackView.bottomAnchor, constant: -10).isActive = true
        stepInput.heightAnchor.constraint(equalToConstant: 188).isActive = true
        stepInput.setContentHuggingPriority(250, for: .horizontal)
        stepInput.setContentHuggingPriority(250, for: .vertical)
        
    
        // add attachment view (附件)
        let attachmentBackView = UIView()
        backView.addArrangedSubview(attachmentBackView)
        attachmentBackView.translatesAutoresizingMaskIntoConstraints = false
        
        let attachmentTitle = UILabel()
        attachmentTitle.text = "附件"
        attachmentBackView.addSubview(attachmentTitle)
        attachmentTitle.translatesAutoresizingMaskIntoConstraints = false
        attachmentTitle.leadingAnchor.constraint(equalTo: attachmentBackView.leadingAnchor, constant: 15).isActive = true
        attachmentTitle.trailingAnchor.constraint(equalTo: attachmentBackView.trailingAnchor, constant: -15).isActive = true
        attachmentTitle.topAnchor.constraint(equalTo: attachmentBackView.topAnchor, constant: 20).isActive = true
        
        attachmentBackView.addSubview(attachmentView)
        attachmentView.translatesAutoresizingMaskIntoConstraints = false
        attachmentView.leadingAnchor.constraint(equalTo: attachmentBackView.leadingAnchor, constant: 0).isActive = true
        attachmentView.trailingAnchor.constraint(equalTo: attachmentBackView.trailingAnchor, constant: 0).isActive = true
        attachmentView.topAnchor.constraint(equalTo: attachmentTitle.bottomAnchor, constant: 0).isActive = true
        attachmentView.bottomAnchor.constraint(equalTo: attachmentBackView.bottomAnchor, constant: 0).isActive = true
        
        
        // add save view（保存）
        let saveBackView = UIView()
        backView.addArrangedSubview(saveBackView)
        saveBackView.translatesAutoresizingMaskIntoConstraints = false
        
        let saveBtn = UIButton(type: .system)
        saveBtn.setTitle("创建", for: .normal)
        saveBtn.setTitleColor(UIColor.black, for: .normal)
        saveBtn.backgroundColor = UIColor.orange
        saveBackView.addSubview(saveBtn)
        saveBtn.addTarget(self, action: #selector(handleCreateBtn), for: .touchUpInside)
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.leadingAnchor.constraint(equalTo: saveBackView.leadingAnchor, constant: 80).isActive = true
        saveBtn.trailingAnchor.constraint(equalTo: saveBackView.trailingAnchor, constant: -80).isActive = true
        saveBtn.topAnchor.constraint(equalTo: saveBackView.topAnchor, constant: 50).isActive = true
        saveBtn.bottomAnchor.constraint(equalTo: saveBackView.bottomAnchor, constant: -50).isActive = true
        
        
    }
    
    
    // 显示picker VC 并处理数据
    func showPickerVC(_ index: Int) {
        print("Tap index: \(index)")
        
        // picker VC
        let pickerVC: PickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PickerVC") as! PickerViewController
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.modalPresentationStyle = .overFullScreen
        // 传值
        pickerVC.dataArray = ["a", "b", "c", "d"]
        // 回传值
        pickerVC.passValueClosure = { id in
            print("Get index: \(index)")
            // 更新detail label
            let selectedView = self.selectViews[index]
            //selectedView.detail.text = "\(id)"
            selectedView.detail.attributedText = NSAttributedString(string: "\(id)", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
            // 更新model
        }
        // present
        self.present(pickerVC, animated: true, completion: nil)
    }
    
    // 创建button action
    func handleCreateBtn(sender: UIButton) {
        print("Create bug...")
        
        // 请求数据
        
        // 
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
