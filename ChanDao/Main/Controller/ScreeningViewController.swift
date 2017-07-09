//
//  ScreeningViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/7.
//  Copyright © 2017年 owen. All rights reserved.
//

import UIKit

let CVW = UIScreen.main.bounds.width - 60
let CVH = UIScreen.main.bounds.height - 20

class ScreeningViewController: UIViewController, UICollectionViewDataSource {
    
    let collectionView: UICollectionView = {
        // 实例化layout并配置
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CVW/3 - 10, height: 30)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: CVW, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        //layout.sectionHeadersPinToVisibleBounds = true
        // 实例化collection view并配置
        let frame = CGRect(x: 60, y: 20, width: CVW, height: CVH)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        // 注册collecion view cell
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ScreeningCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Screening"
        self.view.backgroundColor = UIColor.gray
        
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreeningCell", for: indexPath)
        item.backgroundColor = UIColor.orange
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as! SectionHeaderView
            headerView.backgroundColor = UIColor.lightGray
            headerView.screeningTag = ScreeningTag(id: "111", name: "Section Header")
            return headerView
        }
        return UICollectionReusableView()
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
