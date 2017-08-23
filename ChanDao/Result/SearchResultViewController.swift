//
//  SearchResultViewController.swift
//  ChanDao
//
//  Created by libowen on 2017/8/21.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 说明：显示搜索结果
 
 */

import UIKit

class SearchResultViewController: UIViewController, UITableViewDataSource {
    
    /// properties
    var parameters: [String: String]?
    var results: [ResultModel] = []
    var spinner: UIActivityIndicatorView!
    var headers: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    /// IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.dataSource = self
        
        // 1.1 注册cell
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        
        // spinner
        setUpSpinner()
        self.spinner.startAnimating()
        //self.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("parameters: \(String(describing: parameters))")
        self.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /// data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.2 复用cell
        let cell: ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultTableViewCell
        cell.resultModel = results[indexPath.row]
        return cell
    }
    
    
    /// MARK: helper
    
    // 设置spinner
    func setUpSpinner() {
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        spinner.center = CGPoint(x: tableView.center.x, y: tableView.center.y - 200)
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        spinner.color = UIColor.blue
        self.tableView.addSubview(spinner)
    }

    func requestData() {
        print("SearchResultViewController: requestData")
        Network.post(url: "http://zentao.cct.cn/app/search-bug", headers: headers, paremeters: parameters!) { (data, response, error) in
            
            print("response: \(String(describing: response))")
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let dataArray: [[String: String]] = (jsonDict as! [String: Any])["data"] as! [[String : String]]
                var results = [ResultModel]()
                results = dataArray.map {
                    ResultModel(
                        developer: $0["developer_name"]!,
                        product: $0["product"]!,
                        project: $0["project"]!,
                        level: $0["bug_level"]!,
                        totalCount: $0["total_count"]!
                    )
                }
                self.results = results
                // 返回主线程，更新tableView
                DispatchQueue.main.async {
                    print("go back to main")
                    self.spinner.stopAnimating()
                    self.tableView.reloadData()
                }
            } catch let error {
                print("request error: \(error)")
            }
        }
    }

}
