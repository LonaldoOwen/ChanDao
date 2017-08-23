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
    
    var spinner: UIActivityIndicatorView!
    
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
        
        // segment
        navigationBarWithSegment.isTranslucent = false
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.rowHeight = 50
        
        // spinner
        setUpSpinner()
        self.spinner.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.barTintColor = barBackgroundColor
        // request data
        requestData(withUrlString: "http://zentao.cct.cn/app/get-worst-all")
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
    
    @IBAction func handleSegmented(_ sender: UISegmentedControl) {
        print("handleSegmented")
        print(sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex {
        case 1:
            requestData(withUrlString: "http://zentao.cct.cn/app/get-best-all")
        default:
            requestData(withUrlString: "http://zentao.cct.cn/app/get-worst-all")
        }
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
        cell.ranking = dataModels[indexPath.row]
        return cell
    }
    
    // MARK: table view delegate
    
    
    /// MARK:
    func requestData(withUrlString url: String) {
        print("requestData(withUrlString: \(url))")
        self.spinner.startAnimating()
        Network.get(url: url) { (data, response, error) in
            
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("jsonData: \(jsonData)")
                let dataArray: [[String: Any]] = (jsonData as! [String: Any])["data"] as! [[String : Any]]
                var rankings = [RankingModel]()
                rankings = dataArray.enumerated().map {
                    RankingModel(
                        index: String($0),
                        name: $1["realname"] as! String,
                        totalCount: $1["resolvedNum"] as! String
                    )
                }
                self.dataModels =  rankings
                print("dataModels: \(self.dataModels)")
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
    
    /// MARK: helper
    
    // 设置spinner
    func setUpSpinner() {
        spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        spinner.center = CGPoint(x: tableView.center.x, y: tableView.center.y - 200)
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        spinner.color = UIColor.blue
        self.tableView.addSubview(spinner)
    }

}

