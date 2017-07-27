//
//  CustomView.swift
//  ChanDao
//
//  Created by libowen on 2017/7/27.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

class CustomView: UIControl {
    
    ///
    func setupUI() {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 80, height: 30)
        self.addSubview(label)
        label.text = "aLabel"
    }
    
    
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CustomView: init(frame:)")
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("CustomView: init?(coder)")
        setupUI()
    }
    
    ///
    /*覆写touch事件方法，就不会调用上面的方法？？？*/
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //
        print("CustomView: beginTracking")
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //
        print("CustomView: continueTracking")
        self.sendActions(for: .touchUpInside)
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        //
        print("CustomView: endTracking")
        
    }
    override func cancelTracking(with event: UIEvent?) {
        //
        print("CustomView: cancelTracking")
    }
    
    ///
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        print("CustomView: touchesBegan")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesMoved")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesEnded")
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CustomView: touchesCancelled")
    }

    
    /// 
    /*如果未覆写此方法，执行VC中#selector中的方法，*/
//    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
//        print("CustomView: sendAction(_:to:for:)")
//    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
