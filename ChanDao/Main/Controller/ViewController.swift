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
    
    var dataModels: [RankingModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        //view.isOpaque = false
        //view.alpha = 0.1
        //view.backgroundColor = UIColor.gray
        
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
        navigationBarWithSegment.isTranslucent = false
        
        //
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100
        
        // request data
        requestData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.barTintColor = barBackgroundColor
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
        let screeingVC = SecondScreeningViewController()
        self.show(screeingVC, sender: nil)
    }
    
    
    // MARK: data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataModels?.count)!
        //return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankingCell") as! RankingTableViewCell
//        cell.rankLabel.text = "\(indexPath.row)"
//        cell.nameLabel.text = "头像：同我的微店中设置的头像，点击弹层展示更换头像的方式，可以调起相机的前置摄像头拍摄，也可以从相册中选择。"
//        cell.totalCountLabel.text = "999"
        cell.ranking = dataModels?[indexPath.row]       
        return cell
    }
    
    // MARK: table view delegate
    
    
    /// MARK:
    func requestData() {
        Network.get(url: "http://zentao.cct.cn/app/get-worst-all") { (data, response, error) in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("jsonData: \(jsonData)")
                let dataArray: [[String: Any]] = (jsonData as! [String: Any])["data"] as! [[String : Any]]
                var rankings = [RankingModel]()
                rankings = dataArray.map {
                    RankingModel(
                        index: String(describing: $0.index(forKey: "realname")),
                        name: $0["realname"] as! String,
                        totalCount: $0["resolvedNum"] as! String
                    )
                }
                self.dataModels = rankings
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("request error: \(error)")
            }
        }
    }

}

