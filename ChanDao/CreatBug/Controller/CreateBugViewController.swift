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

class CreateBugViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    /*
    var parameters = [
        "product": "16",                // 产品id
        "module": "360",                // 模块
        "project": "168",               // 项目id
        "openedBuild[]": "226",         // 版本
        "assignedTo": "chentianyu",
        "type": "codeerror",
        "os": "",
        "browser": "",
        "color": "",
        "title": "test提交带附件2",       // 标题
        "severity": "3",                // 级别
        "pri": "0",
        "steps": "<p>[步骤]</p>:\n<p>test1</p>:\n<p>test2</p>:\n<p>[结果]</p>:\n<p>result1</p>:\n<p>结果2</p>:\n<p>[期望]</p>:",//  步骤
        "story": "",
        "task": "",
        "mailto[]": "",
        "keywords": "",
        "files[]": "修改信任设置.png",     // 附件file title
        "labels[]": "",
        "case": "0",
        "caseVersion": "0",
        "result": "0",
        "testtask": "0",
    ]
    */
    
    var parameters = [
        [
            "name": "product",
            "value": "16"
        ],
        [
            "name": "module",
            "value": "360"
        ],
        [
            "name": "project",
            "value": "168"
        ],
        [
            "name": "openedBuild[]",
            "value": "226"
        ],
        [
            "name": "assignedTo",
            "value": "chentianyu"
        ],
        [
            "name": "type",
            "value": "codeerror"
        ],
        [
            "name": "os",
            "value": ""
        ],
        [
            "name": "browser",
            "value": ""
        ],
        [
            "name": "color",
            "value": ""
        ],
        [
            "name": "title",
            "value": "test提交带附件--app01"       // 标题
        ],
        [
            "name": "severity",
            "value": "3"
        ],
        [
            "name": "pri",
            "value": "0"
        ],
        [
            "name": "steps",                // 步骤
            "value": "<p>[步骤]</p>:"
        ],
        [
            "name": "story",
            "value": ""
        ],
        [
            "name": "task",
            "value": ""
        ],
        [
            "name": "mailto[]",
            "value": ""
        ],
        [
            "name": "keywords",
            "value": ""
        ],
        [
            "name": "files[]",
            "fileName": "test-image.JPG",
            "content": ""                   // 附件
        ],
        [
            "name": "labels[]",
            "value": ""
        ],
        [
            "name": "case",
            "value": "0"
        ],
        [
            "name": "caseVersion",
            "value": "0"
        ],
        [
            "name": "result",
            "value": "0"
        ],
        [
            "name": "testtask",
            "value": "0"
        ]
    ]
    
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
            //
            selectedView.tapDetailHandler = { [weak self] in
                // show pickerVC
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
        
        attachmentView.tapAddImageHandler = { [weak self] in
            
            // 调起相册
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                self?.present(imagePicker, animated: true, completion: {
                    //
                })
            } else {
                print("相册不可用。。。")
            }
            
        }
        
        
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
    
    
    /// Delegate -- UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("didFinishPickingMediaWithInfo")
        
        // 收起相册VC
        picker.dismiss(animated: true) { 
            // 设置图片
            let image: UIImage = info["UIImagePickerControllerOriginalImage"] as! UIImage
            self.attachmentView.setImage(image)
            // 设置参数
            for (index, parameter) in self.parameters.enumerated() {
                if parameter["content"] == "" {
                    // 删除当前parameter
                    self.parameters.remove(at: index)
                    
                    let imageData = UIImageJPEGRepresentation(image, 0.5)
                    /*
                     问题：content 为nil？？？
                     */
                    //let content = String(data: imageData!, encoding: String.Encoding.utf8)
                    let content = imageData?.base64EncodedString()
                    let newParameter = [
                        "name": "files[]",
                    "fileName": "test-image.JPG",
                     "content": content]
                    // 添加新parameter
                    self.parameters.append(newParameter as! [String : String])
                }
            }
        }
    }
    
    
    /// Helper methods
    
    // 显示picker VC 并处理数据
    func showPickerVC(_ index: Int) {
        print("Tap index: \(index)")
        
        // picker VC
        let pickerVC: PickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PickerVC") as! PickerViewController
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.modalPresentationStyle = .overFullScreen
        // 传值
        // 将点击的类型对应的数据传给pickerVC
        pickerVC.dataArray = ["a", "b", "c", "d"]
        // 回传值
        pickerVC.passValueClosure = { id in
            
            print("Get index: \(index)")
            // 更新detail label
            let selectedView = self.selectViews[index]
            selectedView.detail.attributedText = NSAttributedString(string: "\(id)", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
            // 更新model
            // 根据detail的显示数据找到对应的id，设置对应parameter
            
        }
        // present
        self.present(pickerVC, animated: true, completion: nil)
    }
    
    // 创建button action
    func handleCreateBtn(sender: UIButton) {
        print("Create bug...")
        
        // 上传数据
        uploadDate()
        // 
    }
    
    // 上传数据
    func uploadDate() {
        
        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "host": "chandao.cct.cn",
            "proxy-connection": "keep-alive",
            "pragma": "no-cache",
            "cache-control": "no-cache",
            "accept": "application/json, text/javascript, */*; q=0.01",
            "origin": "http://chandao.cct.cn",
            "x-requested-with": "XMLHttpRequest",
            "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36",
            "referer": "http://chandao.cct.cn/index.php?m=bug&f=create&productID=16&branch=0&extra=moduleID=0",
            "accept-encoding": "gzip, deflate",
            "accept-language": "zh-CN,zh;q=0.8,en;q=0.6",
            "cookie": "preBranch=0; lastProduct=16; sid=t5hus0j9ftb8e1kkqjmt5i4824; lang=zh-cn; theme=default"
        ]
        
        
        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
        
        /*
        var body = ""
        //let error: NSError? = nil
        for param in parameters {
            let paramName = param["name"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition: form-data; name=\"\(paramName)\""
            if let filename = param["fileName"] {
                let contentType = "image/jpeg"
//                let fileContent = try? String(contentsOfFile: filename, encoding: String.Encoding.utf8)
//                if (error != nil) {
//                    print(error!)
//                }
                let fileContent = param["content"]
                
                body += "; filename=\"\(filename)\"\r\n"
                body += "Content-Type: \(contentType)\r\n\r\n"
                body += fileContent!
            } else if let paramValue = param["value"] {
                body += "\r\n\r\n\(paramValue)"
                body += "\n"
            }
        }
        body += "\n" + boundary
        let postData = body.data(using: String.Encoding.utf8)
        */
        let body: NSMutableData = NSMutableData()
        for param in parameters {
            let paramName = param["name"]
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(paramName)\"")
            if let filename = param["fileName"] {
                let contentType = "image/jpeg"
                let fileContent = param["content"]
                let imageContent = Data.init(base64Encoded: fileContent!, options: [])
                body.appendString("; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(contentType)\r\n\r\n")
                body.append(imageContent!)
            } else if let paramValue = param["value"] {
                body.appendString("\r\n\r\n\(paramValue)")
                body.appendString("\n")
            }
        }
        body.appendString("\n--\(boundary)")
        
        
        
        let url = NSURL(string: "http://chandao.cct.cn/index.php?m=bug&f=create&productID=16&branch=0&extra=moduleID%3D0")! as URL
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = body as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
            }
        })
        
        dataTask.resume()
        
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


extension NSMutableData {
    
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}







