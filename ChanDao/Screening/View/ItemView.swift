//
//  ItemView.swift
//  ChanDao
//
//  Created by libowen on 2017/7/25.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
    说明：自定义UIView使用Xib
 
*/

import UIKit

@IBDesignable class ItemView: UIControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    /// Properties
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var valueText: UILabel!
    @IBOutlet weak var iamgeView: UIImageView!
    
    @IBInspectable var text: String? {
        get {
            return titleText.text
        }
        set(text) {
            titleText.text = text
        }
    }
    
    
    /// initializer
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ItemView: init(frame:)")
        setupView()
    }
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("ItemView: init?(coder)")
        //
        setupView()
    }
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        print("ItemView: awakeFromNib")
        //setupView()
    }
    //
    override func layoutSubviews() {
        print("ItemView: layoutSubviews")
        //
        //setupView()
    }
    
    /*
    /// MARK:
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //
        print("ItemView: beginTracking")
        return true
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //
        print("ItemView: continueTracking")
        self.sendActions(for: .touchUpInside)
        return true
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        //
        print("ItemView: endTracking")

    }
    override func cancelTracking(with event: UIEvent?) {
        //
        print("ItemView: cancelTracking")
    }
    
    ///
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
        print("ItemView: touchesBegan")
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ItemView: touchesMoved")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ItemView: touchesEnded")
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ItemView: touchesCancelled")
    }
    */
    
    /// MARK:
//    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
//        //
//        super.sendAction(action, to: target, for: event)
//        print("ItemView: sendAction(_:to:for:)")
//    }
    
    
    
    /// Private helper methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view
        addSubview(view)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.backgroundColor = UIColor.orange
        return view
    }
    
    ///

}
