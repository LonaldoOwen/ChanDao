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
        
        //
        let customView = CustomView(frame: CGRect(x: 10, y: 100, width: 100, height: 50))
        customView.backgroundColor = UIColor.lightGray
        view.addSubview(customView)
        customView.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        
        
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
