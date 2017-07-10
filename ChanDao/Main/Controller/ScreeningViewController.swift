//
//  ScreeningViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/7.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

let CVW = UIScreen.main.bounds.width - 40
let CVH = UIScreen.main.bounds.height

class ScreeningViewController: UIViewController, UICollectionViewDataSource {
    
    var screeningTags: [ScreeningTag]?
    
    let collectionView: UICollectionView = {
        // 实例化layout并配置
        let layout = UICollectionViewFlowLayout()
        let itemWidth = (CVW - 15*2 - 10*2)/3
        layout.itemSize = CGSize(width: itemWidth, height: 34)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: CVW, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 35, right: 15)
        // 实例化collection view并配置
        let frame = CGRect(x: CVW+40, y: 0, width: CVW, height: CVH)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets.init(top: 35, left: 0, bottom: 0, right: 0)
        // 注册collecion view cell
        collectionView.register(ScreeningCell.self, forCellWithReuseIdentifier: "ScreeningCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Screening"
        readPropertyList()
        
        //
        self.view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        
        // 注册Supplementary View（header or footer）
        collectionView.register(SectionHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)
        
        //
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // add animation(from right to left)
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.frame = CGRect(x: 40, y: 0, width: CVW, height: CVH)
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // add animation(from left to right)
        UIView.animate(withDuration: 0.3, animations: {
            self.collectionView.frame = CGRect(x: CVW+40, y: 0, width: CVW, height: CVH)
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap() {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: data source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (screeningTags?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (screeningTags![section].subTags?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: ScreeningCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreeningCell", for: indexPath) as! ScreeningCell
        item.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        item.screeningTag = screeningTags?[indexPath.section].subTags?[indexPath.item]
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            headerView.backgroundColor = UIColor.lightGray
            //headerView.screeningTag = ScreeningTag(id: "111", name: "Section Header", subTags: [ScreeningTag.init(id: "0", name: "000", subTags: [])])
            headerView.screeningTag = screeningTags?[indexPath.section]
            return headerView
        }
        return UICollectionReusableView()
    }
    
    // MARK: helper
    func readPropertyList() {
        let path = Bundle.main.path(forResource: "ScreeningTag", ofType: "plist")
        let fileManager = FileManager.default
        let screeningData = fileManager.contents(atPath: path!)
        let screeningArray: [[String: Any]] = try! PropertyListSerialization.propertyList(from: screeningData!, options: [], format: nil) as! [[String: Any]]
        var tags = [ScreeningTag]()
        tags = screeningArray.map{
            ScreeningTag(
                id: $0["id"] as! String,
                name: $0["name"] as! String,
                subTags: ($0["subTags"] as! [[String: Any]]).map {
                    ScreeningTag(
                        id: $0["id"] as! String,
                        name: $0["name"] as! String,
                        subTags: [ScreeningTag]()
                    )
                }
            )
        }
        screeningTags = tags
    
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
