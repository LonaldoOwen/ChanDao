//
//  ViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/7.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBarWithSegment: UINavigationBar!
    
    /**
     问题：
     1、var dataModels: [RankingModel]？，optional类型时，dataModls总是为nil？？？
     2、var dataModels: [RankingModel]！，非optional时，numberOfRowsInSection里报错？？？
    */
    var dataModels: [RankingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        navigationBarWithSegment.isTranslucent = false
        
        //
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.rowHeight = 50
        
        // request data
        //requestData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.barTintColor = barBackgroundColor
        // request data
        requestData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: action
    @IBAction func showCollection(_ sender: Any) {
        /*
        // 第一种方式
        let screeningVC = ScreeningViewController()
        screeningVC.view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.2)
        screeningVC.modalTransitionStyle = .crossDissolve
        screeningVC.modalPresentationStyle = .overFullScreen
        navigationController?.present(screeningVC, animated: true, completion: nil)
        */
        // 第二种方式：
//        let screeingVC = SecondScreeningViewController()
//        self.show(screeingVC, sender: nil)
    }
    
    
    // MARK: data source
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        return self.dataModels.count
        //return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankingCell") as! RankingTableViewCell
//        cell.rankLabel.text = "\(indexPath.row)"
//        cell.nameLabel.text = "头像：同我的微店中设置的头像，点击弹层展示更换头像的方式，可以调起相机的前置摄像头拍摄，也可以从相册中选择。"
//        cell.totalCountLabel.text = "999"
        cell.ranking = dataModels[indexPath.row]
        return cell
    }
    
    // MARK: table view delegate
    
    
    /// MARK:
    func requestData() {
        print("requestData")
        Network.get(url: "http://zentao.cct.cn/app/get-worst-all") { (data, response, error) in
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("jsonData: \(jsonData)")
                let dataArray: [[String: Any]] = (jsonData as! [String: Any])["data"] as! [[String : Any]]
                var rankings = [RankingModel]()
                rankings = dataArray.map {
                    RankingModel(
                        index: "00",
                        name: $0["realname"] as! String,
                        totalCount: $0["resolvedNum"] as! String
                    )
                }
                self.dataModels =  rankings
                print("dataModels: \(self.dataModels)")
                DispatchQueue.main.async {
                    print("go back to main")
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("request error: \(error)")
            }
        }
    }

}

