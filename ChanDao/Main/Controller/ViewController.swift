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
        //
        //view.isOpaque = false
        //view.alpha = 0.1
        //view.backgroundColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showCollection(_ sender: Any) {
        let screeningVC = ScreeningViewController()
        screeningVC.view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0.2)
        screeningVC.modalTransitionStyle = .crossDissolve
        screeningVC.modalPresentationStyle = .overFullScreen
        navigationController?.present(screeningVC, animated: true, completion: nil)
    }
    

}

