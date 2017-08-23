//
//  PickerViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/29.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 说明：使用UIPickerView用于显示可选内容
 */

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    /// properties
    @IBOutlet var pickerView: UIPickerView!
    var dataArray: [Any] = []
    var passValueClosure: (Int) -> Void = { (index) -> Void in }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 配置root view
        view.backgroundColor = UIColor(red: 50/255.0, green: 50/255.0, blue: 50/255.0, alpha: 0.3)
        
        // pickerView
        pickerView.dataSource = self
        pickerView.delegate = self
        print("viewDidLoad: dataArray: \(dataArray)")
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        //
        print("viewWillAppear: dataArray: \(dataArray)")
        //pickerView.selectRow(0, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    /// MARK: actions
    
    // 取消
    @IBAction func handleCancelClick(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // 确定
    @IBAction func handleConfirmClick(_ sender: UIButton) {
        // 传值：返回选择项
        self.passValueClosure(pickerView.selectedRow(inComponent: 0))
        // 收起pickerVC
        dismiss(animated: true) {
            print("Alredy dismiss pickerVC")
        }
    }
    
    
    /// pickerView dataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    
    /// pickerView delegate
    
    // 设置row上面显示的文本
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row] as? String
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
