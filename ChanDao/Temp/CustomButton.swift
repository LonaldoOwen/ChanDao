//
//  CustomButton.swift
//  ChanDao
//
//  Created by libowen on 2017/7/27.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class CustomButton: UIControl {
    @IBOutlet weak var titleText: UILabel!

    
    class func customButton(withTitle title: String) -> CustomButton {
        let nib = UINib(nibName: "CustomButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil).first as! CustomButton
        btn.titleText.text = title
        return btn
    }
    
    

}
