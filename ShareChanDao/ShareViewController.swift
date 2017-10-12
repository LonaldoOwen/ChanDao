//
//  ShareViewController.swift
//  ShareChanDao
//
//  Created by libowen on 2017/8/22.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        print("didSelectPost()")
        
        guard let inputItem: NSExtensionItem = self.extensionContext?.inputItems.first as? NSExtensionItem else { return }
        guard let attachments: [NSItemProvider] = inputItem.attachments as? [NSItemProvider] else { return }
        for itemProvider in attachments {
            if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg") {
                print("itemProvider: \(itemProvider)")
                itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil, completionHandler: { (item, error) in
                    guard let item: NSObject = item as? NSObject else { return }
                    var imageData: NSData!
                    if item.isKind(of: NSURL.self) {
                        guard let fileUrl = item as? NSURL else { return }
                        imageData = NSData(contentsOf: fileUrl as URL)
                    }
                    if item.isKind(of: UIImage.classForCoder()) {
                        guard let fileImage = item as? UIImage else { return }
                        imageData = UIImagePNGRepresentation(fileImage)! as NSData
                    }
                    let dict: [String: Any] = ["imageData": imageData, "name": self.contentText]
                    let userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.owen.ChanDao")!
                    userDefaults.setValue(dict, forKey: "image")
                    userDefaults.synchronize()
                    // 标记有新的分享
                    userDefaults.set(true, forKey: "has-new-share")
                    print("Store share in userDefaults")
                })
            }
        }
        
//        let inputItem: NSExtensionItem = self.extensionContext?.inputItems.first as! NSExtensionItem
//        print("inputItem: \(inputItem)")
//        //
//        for itemProvider in inputItem.attachments! {
//            
//            let itemProvider: NSItemProvider = itemProvider as! NSItemProvider
//            
//            if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg") {
//                print("itemProvider: \(itemProvider)")
//                
//                itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: [:], completionHandler: { (item, error) in
//                    
//                    let item: NSObject = item as! NSObject
//                    var imageData: NSData!
//                    if item.isKind(of: NSURL.self) {
//                        imageData = NSData(contentsOf: (item as! NSURL) as URL)
//                    }
//                    if item.isKind(of: UIImage.self) {
//                        imageData = UIImagePNGRepresentation((item as! UIImage))! as NSData
//                    }
//                    let dict: [String: Any] = ["imageData": imageData, "name": self.contentText]
//                    let userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.owen.ChanDao")!
//                    userDefaults.setValue(dict, forKeyPath: "image")
//                    userDefaults.synchronize()
//                    // 标记有新的分享
//                    userDefaults.set(true, forKey: "has-new-share")
//                    print("Store share in userDefaults")
//                })
//            }
//        }
        
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    override func didSelectCancel() {
        print("didSelectCancel()")
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
