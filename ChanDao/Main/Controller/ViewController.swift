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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //
        //view.isOpaque = false
        //view.alpha = 0.1
        //view.backgroundColor = UIColor.gray
        
        ///
        Network.request(method: "POST", url: "http://test.api.fengchaoyou.com/v1/product/detail", parameters: ["data": ["id": "46658"]]) { (data, response, error) in

            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject] {
                    print("jsonData: \(String(describing: jsonData))")
                }
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
            
        }
        
        //
        navigationBarWithSegment.isTranslucent = false
        
        //
        tableView.dataSource = self
        tableView.delegate = self
        
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
        let screeningVC = ScreeningViewController()
        screeningVC.view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.2)
        screeningVC.modalTransitionStyle = .crossDissolve
        screeningVC.modalPresentationStyle = .overFullScreen
        navigationController?.present(screeningVC, animated: true, completion: nil)
    }
    
    
    // MARK: data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RankingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RankingCell") as! RankingTableViewCell
        cell.rankLabel.text = "\(indexPath.row)"
        return cell
    }
    
    // MARK: table view delegate
    

}

