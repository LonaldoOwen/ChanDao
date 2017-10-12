//
//  TempViewController.swift
//  ChanDao
//
//  Created by libowen on 2017/7/27.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    
    
    @IBOutlet weak var viewAction: UIView!
    
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var controlAction: UIControl!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ///
        /*
         let headers = [
         "Content-Type": "application/json",
         "seqnum": "0",
         "ver": "1.0",
         "uid": "498",
         "token": "nq4LWlvy7lJW-kh07fRRuDGeBwRvpnsJ0BGl17Xe4eeZEwvXwQN8HoBAluLmJbpQ",
         ]
         Network.request(method: "POST", url: "http://test.api.fengchaoyou.com/v1/product/detail", headers: headers, parameters: ["data": ["id": "46658"]]) { (data, response, error) in
         
         do {
         if let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject] {
         print("jsonData: \(String(describing: jsonData))")
         }
         } catch let error {
         print("error: \(error.localizedDescription)")
         }
         
         }
         */
        
        //
        let customView = CustomView(frame: CGRect(x: 10, y: 100, width: 100, height: 50))
        customView.backgroundColor = UIColor.lightGray
        view.addSubview(customView)
        customView.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        
        
        // 验证图像转String
        if let path = Bundle.main.path(forResource: "加号" , ofType: ".png") {
            do {
                let fileContent = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                print("fileContent: \(fileContent))")
            } catch let error {
                print("error: \(error)")
            }
        } else {
            print("path not found")
        }
        //print("fileContent: \(String(describing: fileContent))")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        itemView.backgroundColor = UIColor.lightGray
        itemView.titleText.text = "title"
        
        //
        /*创建不了，报错*/
//        let btn = CustomButton.customButton(withTitle: "button")
//        view.addSubview(btn)
    }
    
    
    override func viewWillLayoutSubviews() {
        //
//        itemView.backgroundColor = UIColor.lightGray
//        itemView.titleText.text = "title"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// MARK: actions
    @objc func handleClick(_ sender: UIControl) {
        print("handleClick")
    }
    
    @IBAction func handleItemViewClicik(_ sender: UIControl) {
        print("handleItemViewClicik")
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
