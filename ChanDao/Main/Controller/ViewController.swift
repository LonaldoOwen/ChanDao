//
//  ViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/7.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showCollection(_ sender: Any) {
        let screeningVC = ScreeningViewController()
        screeningVC.modalTransitionStyle = .crossDissolve
        navigationController?.present(screeningVC, animated: true, completion: nil)
    }
    

}

