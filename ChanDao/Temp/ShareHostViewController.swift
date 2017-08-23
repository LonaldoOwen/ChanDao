//
//  ShareHostViewController.swift
//  ChanDao
//
//  Created by libowen on 2017/8/22.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class ShareHostViewController: UIViewController {

    ///
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageName: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ShareHostViewController: viewDidLoad")

        // Do any additional setup after loading the view.
        self.imageView.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ShareHostViewController: viewWillAppear")
        
        let defults = UserDefaults(suiteName: "group.com.owen.ChanDao")
        guard (defults?.bool(forKey: "has-new-share"))! else {
            print("Has no new share")
            return
        }
        let dict: [String: Any]? = defults?.dictionary(forKey: "image")
        if let dict = dict {
            let imageData: NSData = dict["imageData"] as! NSData
            self.imageView.image = UIImage(data: imageData as Data)
            self.imageName.text = dict["name"] as? String
            defults?.removeObject(forKey: "image")
            defults?.set(false, forKey: "has-new-share")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ShareHostViewController: viewDidAppear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
