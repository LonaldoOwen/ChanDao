//
//  ThirdViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/28.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 筛选条件页面：
 
 */

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet var bugLevel: UILabel!
    @IBOutlet var product: UILabel!
    @IBOutlet var project: UILabel!
    @IBOutlet var developer: UILabel!
    
    /*存放所有选择条件内容*/
    var allData: [Any] = []
    /*存放条件数组的字典*/
    var screeingDic: [String: Any] = [:]
    /*存放传递的数组*/
    var screeningItems: [String] = []
    /*存放request参数*/
    var parameters: [String: String] = [
    "product": "",
    "project": "",
    "developer": "",
    "bugLevel": ""
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /// 默认配置
        // 初始条件都为空
        bugLevel.text = ""
        product.text = ""
        project.text = ""
        developer.text = ""
        
        // 读取property lsit数据
        allData = Helper.readPlist(forResource: "TempTags", ofType: "plist")
        print("allData: \(allData)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// MARK: actions
    
    // 筛选条件
    @IBAction func handleClick(_ sender: UIControl) {
        print("Clicked on: \(sender.tag)")
        // filter:根据当前参数列表情况生成查询条件
        var screeningCaseToShow = ScreeningCase.zero
        screeningCaseToShow = getCurrentCase()
        filterCases(screeningCaseToShow)
        // 选择不同条件传递相应值
        filterScreeingItems(sender)
        // 显示VC
        showPickerVC(sender)
    }
    
    
    /// MARK: helper methods
    
    /*
    /// 方法一：if else判断，这个操作起来太繁琐了，
    // filter： 根据选择情况传递不同内容
    func filterScreeingItems(_ sender: UIControl) {
        switch sender.tag {
        case 10:
            screeningItems = filterBugLevel()
        case 11:
            screeningItems = filterProduct()
        case 12:
            screeningItems = filterProject()
        case 13:
            screeningItems = filterDeveloper()
        default:
            screeningItems = []
        }
    }
    
    // 过滤产品
    func filterProduct() -> [String] {
        var tempProducts: [String] = []
        
        if parameters["product"] == "" {
        // product如果为空
            if parameters["project"] == "" {
            // project为空
                if parameters["developer"] == "" {
                // developer为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回所有产品
                        tempProducts =  getAllProduct()
                    } else {
                    // bugLevel不为空
                        // 返回所有包含bugLevel的产品
                        
                    }
                    
                } else {
                // developer不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回包含developer的所有产品
                    } else {
                    // bugLevel不为空
                        // 返回所有包含developer同时bugLevel的产品
                    }
                }
            } else {
            // project不为空
                // 返回project对应的产品
            }
        } else {
        // product不为空
            if parameters["project"] == "" {
            // project为空
                if parameters["developer"] == "" {
                // developer为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回所有产品
                        tempProducts =  getAllProduct()
                    } else {
                        // bugLevel不为空
                        // 返回所有包含bugLevel的产品
                    }
                } else {
                // developer不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回包含developer的所有产品
                    } else {
                    // bugLevel不为空
                        // 返回所有包含developer同时bugLevel的产品
                    }
                }
            } else {
            // project不为空
                // 返回project对应的产品
            }
        }
        
        return tempProducts
    }
    
    // 过滤项目
    func filterProject() -> [String]{
        var tempProjects: [String] = []
        
        if parameters["project"] == "" {
        // project为空
            if parameters["product"] == "" {
            // product为空
                if parameters["developer"] == "" {
                // developer 为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回所有项目
                        tempProjects = getAllProject()
                    } else {
                    // bugLevel不为空
                        // 返回包含bugLevel的项目
                    }
                } else {
                // developer不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回包含developer的项目
                    } else {
                    // bugLevel不为空
                        // 返回包含developer和bugLevel的项目
                    }
                }
            } else {
            // product不为空
                // 返回当前product
            }
            
        } else {
        // project不为空
            // 返回当前值
            tempProjects.append(parameters["project"]!)
        }
        
        return tempProjects
    }
    
    // 过滤开发
    func filterDeveloper() -> [String] {
        var tempDevelopers: [String] = []
        
        if parameters["developer"] == "" {
        // developer为空
            if parameters["product"] == "" {
            // product为空
                if parameters["project"] == "" {
                // project为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回所有developer
                        tempDevelopers = getAllDeveloper()
                    } else {
                    // bugLevel不为空
                        // 返回所有包含bugLevel的开发
                    }
                } else {
                // project不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回所有该project包含的开发
                    } else {
                    // bugLevel不为空
                        // 返回所有该project和bugLevel包含的开发
                    }
                }
            } else {
            // product不为空
                if parameters["project"] == "" {
                // project为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回该product下的所有开发
                    } else {
                    // bugLevel不为空
                        // 返回该product和bugLevel下的所有开发
                    }
                } else {
                // project不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回该project下的开发
                    } else {
                    // bugLevel不为空
                        // 返回该project和包含bugLevel的开发
                    }
                }
            }
        } else {
        // developer不为空
            if parameters["product"] == "" {
            // product为空
                if parameters["project"] == "" {
                // project为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回
                    } else {
                    // bugLevel不为空
                        // 返回
                    }
                } else {
                // project不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回
                    } else {
                    // bugLevel不为空
                        // 返回
                    }
                }
            } else {
                // product不为空
                if parameters["project"] == "" {
                // project为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回
                    } else {
                    // bugLevel不为空
                        // 返回
                    }
                } else {
                // project不为空
                    if parameters["bugLevel"] == "" {
                    // bugLevel为空
                        // 返回
                    } else {
                    // bugLevel不为空
                        // 返回
                    }
                }
            }
        }
        
        return tempDevelopers
    }
    
    // 过滤bug level
    func filterBugLevel() -> [String] {
        var bugLevels: [String] = []
        bugLevels = getAllBugLevel()
        return bugLevels
    }
    */
    
    
    
    /// 方法二：根据已经选中的情况进行组合，然后使用for－in查找
    
    /* 生成过滤情况 */
    func getCurrentCase() -> ScreeningCase {
        print("getCurrentCase")
        let prodect = parameters["product"]
        let project = parameters["project"]
        let developer = parameters["developer"]
        let bugLevel = parameters["bugLevel"]
        
        // .zero
        if prodect == "" && project == "" && developer == "" && bugLevel == "" {
            return ScreeningCase.zero
        }
        
        // .one
//        if prodect == "" && project != "" && developer != "" && bugLevel != "" {
//            return ScreeningCase.one
//        }
//        if prodect != "" && project == "" && developer != "" && bugLevel != "" {
//            return ScreeningCase.one
//        }
//        if prodect != "" && project != "" && developer == "" && bugLevel != "" {
//            return ScreeningCase.one
//        }
//        if prodect != "" && project != "" && developer != "" && bugLevel == "" {
//            return ScreeningCase.one
//        }
        // .one
        if prodect == "" && project == "" && developer == "" && bugLevel != "" {
            return ScreeningCase.one
        }
        if prodect == "" && project == "" && developer != "" && bugLevel == "" {
            return ScreeningCase.one
        }
        if prodect == "" && project != "" && developer == "" && bugLevel == "" {
            return ScreeningCase.one
        }
        if prodect != "" && project == "" && developer == "" && bugLevel == "" {
            return ScreeningCase.one
        }
        
        // .two
        if prodect == "" && project == "" && developer != "" && bugLevel != "" {
            return ScreeningCase.two
        }
        if prodect == "" && project != "" && developer == "" && bugLevel != "" {
            return ScreeningCase.two
        }
        if prodect == "" && project == "" && developer != "" && bugLevel != "" {
            return ScreeningCase.two
        }
        if prodect != "" && project == "" && developer == "" && bugLevel != "" {
            return ScreeningCase.two
        }
        if prodect != "" && project == "" && developer != "" && bugLevel == "" {
            return ScreeningCase.two
        }
        if prodect != "" && project != "" && developer == "" && bugLevel == "" {
            return ScreeningCase.two
        }
        
        
        // .three
//        if prodect == "" && project == "" && developer == "" && bugLevel != "" {
//            return ScreeningCase.three
//        }
//        if prodect == "" && project == "" && developer != "" && bugLevel == "" {
//            return ScreeningCase.three
//        }
//        if prodect == "" && project != "" && developer == "" && bugLevel == "" {
//            return ScreeningCase.three
//        }
//        if prodect != "" && project == "" && developer == "" && bugLevel == "" {
//            return ScreeningCase.three
//        }
        if prodect == "" && project != "" && developer != "" && bugLevel != "" {
            return ScreeningCase.three
        }
        if prodect != "" && project == "" && developer != "" && bugLevel != "" {
            return ScreeningCase.three
        }
        if prodect != "" && project != "" && developer == "" && bugLevel != "" {
            return ScreeningCase.three
        }
        if prodect != "" && project != "" && developer != "" && bugLevel == "" {
            return ScreeningCase.three
        }
        
        // .four
        if prodect != "" && project != "" && developer != "" && bugLevel != "" {
            return ScreeningCase.four
        }
        
        return ScreeningCase.zero
    }

    /* 过滤不同情况 */
    func filterCases(_ name: ScreeningCase) {
        switch name {
        case .zero:
            //
            print("zero")
            filterCaseDefault()
        case .one:
            //
            print("one")
            filterCaseOne()
        case .two:
            //
            print("two")
            filterCaseTwo()
        case .three:
            //
            print("three")
            filterCaseThree()
        case .four:
            //
            print("four")
            filterCaseFour()
        }
    }
    
    // filter： 根据选择情况传递不同内容
    func filterScreeingItems(_ sender: UIControl) {
        switch sender.tag {
        case 10:
            screeningItems = filterBugLevel()
        case 11:
            screeningItems = filterProduct()
        case 12:
            screeningItems = filterProject()
        case 13:
            screeningItems = filterDeveloper()
        default:
            screeningItems = []
        }
    }
    
    
    
    
    func filterBugLevel() -> [String] {
        return screeingDic["bugLevels"] as! [String]
    }
    func filterProduct() -> [String] {
        return screeingDic["products"] as! [String]
    }
    func filterProject() -> [String] {
        return screeingDic["projects"] as! [String]
    }
    func filterDeveloper() -> [String] {
        return screeingDic["developers"] as! [String]
    }
    
    /* 选中0个，都未选中 */
    func filterCaseDefault() {
        
        let products = getAllProduct()
        let projects = getAllProject()
        let developers = getAllDeveloper()
        let bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    /* 选中1个 */
    func filterCaseOne() {
        for product in allData {
            guard parameters["product"] != "" else {
                // 产品选中，构造数据
                caseOne01(product)
                return
            }
            for project in (product as! [String: Any])["projects"] as! [[String: Any]]{
                guard parameters["project"] != "" else {
                    // 项目选中，构造数据
                    caseOne02(project)
                    return
                }
                for developer in project["developers"] as! [[String: Any]] {
                    guard parameters["developer"] != "" else {
                        // 开发选中，构造数据
                        caseOne03(developer)
                        return
                    }
                    // bug级别选中，构造数据
                    caseOne04(developer)
                }
            }
        }
    }
    /* 选中2个 */
    func filterCaseTwo() {}
    /* 选中3个 */
    func filterCaseThree() {}
    /* 选中4个 */
    func filterCaseFour() {}
    
    
    
    
    /* 返回所有产品 */
    func getAllProduct() -> [String] {
        var products: [String] = []
        for product in allData {
            products.append((product as! [String: Any])["product_name"]! as! String)
        }
        return products
    }
    
    /* 返回所有项目 */
    func getAllProject() -> [String] {
        var projects: [String] = []
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                projects.append(project["project_name"] as! String)
            }
        }
        return projects
    }
    /* 返回所有开发 */
    func getAllDeveloper() -> [String] {
        var developers: [String] = []
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]] {
                    developers.append(developer["developer_name"] as! String)
                }
            }
        }
        // 需要去重
        developers = filterRepeat(developers)
        return developers
    }
    /* 返回所有bug级别 */
    func getAllBugLevel() -> [String] {
        var bugLevels: [String] = []
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]] {
                    bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                }
            }
        }
        // 需要去重
        /**
         问题：中文怎么排序？？？
        */
        bugLevels = filterRepeat(bugLevels)
        return bugLevels
    }
    
    /**/
    func caseOne01(_ object: Any) {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        products.append((object as! [String: Any])["product_name"] as! String)
        for project in (object as! [String: Any])["projects"] as! [[String: Any]]{
            projects.append(project["project_name"] as! String)
            for developer in project["developers"] as! [[String: Any]] {
                developers.append(developer["developer_name"] as! String)
                bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
            }
        }
        // 去重
        developers = filterRepeat(developers)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    func caseOne02(_ object: Any) {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        projects.append((object as! [String: Any])["project_name"] as! String)
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                if project["project_name"] as! String == ((object as! [String: Any])["project_name"] as! String) {
                    products.append((product as! [String: Any])["product_name"] as! String)
                }
            }
            
        }
        for developer in (object as! [String: Any])["developers"] as! [[String: Any]]{
            developers.append(developer["developer_name"] as! String)
            bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
        }
        // 去重
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    func caseOne03(_ object: Any) {}
    func caseOne04(_ object: Any) {}
    
    
    
    //
    func filterRepeat(_ array: [String]) -> [String] {
        var tempDic: [String: String] = [:]
        for element in array {
            tempDic.updateValue(element, forKey: element)
        }
        var tempArray: [String] = []
        for value in tempDic.values {
            tempArray.append(value)
        }
        return tempArray
    }
    
    
    
    
    
    // 显示Picker VC
    func showPickerVC(_ sender: UIControl) {
        let pickerVC: PickerViewController = storyboard?.instantiateViewController(withIdentifier: "PickerVC") as! PickerViewController
        pickerVC.modalTransitionStyle = .crossDissolve
        pickerVC.modalPresentationStyle = .overFullScreen
        // 传值
        pickerVC.dataArray = screeningItems
        // 实现Closure
        pickerVC.passValueClosure = { index in
            // 添加到参数array
            switch sender.tag {
            case 10:
                self.parameters.updateValue(self.screeningItems[index], forKey: "bugLevel")
                // 更新选择条件
                self.bugLevel.text = self.screeningItems[index]
            case 11:
                self.parameters.updateValue(self.screeningItems[index], forKey: "product")
                self.product.text = self.screeningItems[index]
            case 12:
                self.parameters.updateValue(self.screeningItems[index], forKey: "project")
                self.project.text = self.screeningItems[index]
            case 13:
                self.parameters.updateValue(self.screeningItems[index], forKey: "developer")
                self.developer.text = self.screeningItems[index]
            default:
                //self.parameters.updateValue(self.screeningItems[index], forKey: "default")
                print("defult")
            }
            print("parameters: \(self.parameters)")
        }
        self.present(pickerVC, animated: true, completion: nil)
    }
   
    
    

}








