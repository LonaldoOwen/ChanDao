//
//  ThirdViewController.swift
//  ChanDao
//
//  Created by owen on 17/7/28.
//  Copyright © 2017年 owen. All rights reserved.
//
/**
 筛选条件页面：使用Storyb创建UI；筛选逻辑本地处理
 
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
    /*参数使用id*/
    var idParameters: [String: String] = [
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
//        allData = Helper.readPlist(forResource: "TempTags", ofType: "plist")
//        print("allData: \(allData)")
        
        // 请求服务器数据
        requestData()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func requestData() {
        Network.get(url: "http://zentao.cct.cn/app/product") { (data, response, error) in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(jsonData)
                self.allData = (jsonData as! [String: Any])["filter"] as! [Any]
            } catch let error {
                print("request filter: \(error)")
            }
        }
    }
    
    
    /// MARK: actions
    
    @IBAction func resetClick(_ sender: UIButton) {
        print("resetClick")
        // label重置
        self.bugLevel.text = ""
        self.product.text = ""
        self.project.text = ""
        self.developer.text = ""
        // parameters重置
        self.parameters = [
        "product": "",
        "project": "",
        "developer": "",
        "bugLevel": ""
        ]
    }
    
    @IBAction func searchClick(_ sender: UIButton) {
        print("searchClick")
        // 跳转到结果页
    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ResultVC" {
            print("ResultVC")
            let destinationVC: SearchResultViewController = segue.destination as! SearchResultViewController
            self.convertParametersToID(parameters)
            destinationVC.parameters = idParameters
        }
        
    }
    
    
    /// MARK: helper methods
    
    func productDict() -> [String: String] {
        var dict: [String: String] = [:]
        for product in allData {
            let product = product as! [String: Any]
            dict.updateValue(product["product_name"] as! String, forKey: product["product_id"] as! String)
        }
        return dict
    }
    func projectDict() -> [String: String] {
        var dict: [String: String] = [:]
        for product in allData {
            let product = product as! [String: Any]
            let projects = product["projects"] as! [[String: Any]]
            for project in projects {
                dict.updateValue(project["project_name"] as! String, forKey: project["project_id"] as! String)
            }
        }
        return dict
    }
    // 将parameters中的product、project转换为id类型
    func convertParametersToID(_ parameters: [String: String]) {
        let productDict = self.productDict()
        let projectDict = self.projectDict()
        productDict.forEach { (key, value) in
            if value == parameters["product"] {
                idParameters["product"] = key
            }
        }
        projectDict.forEach { (key, value) in
            if value == parameters["project"] {
                idParameters["project"] = key
            }
        }
        idParameters["developer"] = parameters["developer"]
        idParameters["bugLevel"] = parameters["bugLevel"]
    }
    

    /// 方法二：根据已经选中的情况进行组合，然后使用for－in查找
    
    /* 生成过滤情况 */
    func getCurrentCase() -> ScreeningCase {
        print("getCurrentCase")
        let product = parameters["product"]
        let project = parameters["project"]
        let developer = parameters["developer"]
        let bugLevel = parameters["bugLevel"]
        
        /// .zero
        if product == "" && project == "" && developer == "" && bugLevel == "" {
            return ScreeningCase.zero
        }
        
        /// .one
        // 4 -> 废弃
        if product == "" && project == "" && developer == "" && bugLevel != "" {
            return ScreeningCase.one
        }
        // 3
        if product == "" && project == "" && developer != "" && bugLevel == "" {
            return ScreeningCase.one
        }
        // 2
        if product == "" && project != "" && developer == "" && bugLevel == "" {
            return ScreeningCase.one
        }
        // 1
        if product != "" && project == "" && developer == "" && bugLevel == "" {
            return ScreeningCase.one
        }
        
        /// .two
        // 34 -> 3
        if product == "" && project == "" && developer != "" && bugLevel != "" {
            return ScreeningCase.two
        }
        // 24 -> 2
        if product == "" && project != "" && developer == "" && bugLevel != "" {
            return ScreeningCase.two
        }
        // 23
        if product == "" && project != "" && developer != "" && bugLevel == "" {
            return ScreeningCase.two
        }
        // 14 -> 1
        if product != "" && project == "" && developer == "" && bugLevel != "" {
            return ScreeningCase.two
        }
        // 13
        if product != "" && project == "" && developer != "" && bugLevel == "" {
            return ScreeningCase.two
        }
        // 12
        if product != "" && project != "" && developer == "" && bugLevel == "" {
            return ScreeningCase.two
        }
        
        /// .three
        // 234 -> 23
        if product == "" && project != "" && developer != "" && bugLevel != "" {
            return ScreeningCase.three
        }
        // 134 -> 13
        if product != "" && project == "" && developer != "" && bugLevel != "" {
            return ScreeningCase.three
        }
        // 124 -> 12
        if product != "" && project != "" && developer == "" && bugLevel != "" {
            return ScreeningCase.three
        }
        // 123
        if product != "" && project != "" && developer != "" && bugLevel == "" {
            return ScreeningCase.three
        }
        
        /// .four -> 废弃
        if product != "" && project != "" && developer != "" && bugLevel != "" {
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
    
    /* 选中0个，都未选中 ，1种(1种完成) */
    func filterCaseDefault() {
        
        let products = getAllProduct()
        let projects = getAllProject()
        let developers = getAllDeveloper()
        let bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    /* 选中1个，4种 （完成）*/
    func filterCaseOne() {
        let product = parameters["product"]
        let project = parameters["project"]
        let developer = parameters["developer"]
        let bugLevel = parameters["bugLevel"]
        
        // 4 -> 废弃
        if product == "" && project == "" && developer == "" && bugLevel != "" {
            caseOne04(forBugLevel: parameters["bugLevel"]!)
        }
        // 3
        if product == "" && project == "" && developer != "" && bugLevel == "" {
            caseOne03(forDeveloper: parameters["developer"]!)
        }
        // 2
        if product == "" && project != "" && developer == "" && bugLevel == "" {
            caseOne02(forProject: parameters["project"]!)
        }
        // 1
        if product != "" && project == "" && developer == "" && bugLevel == "" {
            caseOne01(forProduct: parameters["product"]!)
        }
        
        // 这样判断太耗时了，导致卡顿
//        for product in allData {
//            guard parameters["product"] == "" else {
//                // 产品选中，构造数据
//                print("产品选中，构造数据")
//                caseOne01(forProduct: parameters["product"]!)
//                return
//            }
//            for project in (product as! [String: Any])["projects"] as! [[String: Any]]{
//                guard parameters["project"] == "" else {
//                    // 项目选中，构造数据
//                    print("项目选中，构造数据")
//                    caseOne02(forProject: parameters["project"]!)
//                    return
//                }
//                for _ in project["developers"] as! [[String: Any]] {
//                    if parameters["developer"] != "" {
//                        // 开发选中，构造数据
//                        print("开发选中，构造数据")
//                        caseOne03(forDeveloper: parameters["developer"]!)
//                    } else {
//                        // bug级别选中，构造数据
//                        print("bug级别选中，构造数据")
//                        caseOne04(forBugLevel: parameters["bugLevel"]!)
//                    }
//                }
//            }
//        }
    }
    
    /*产品选中，1 */
    func caseOne01(forProduct name: String) {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        products.append(contentsOf: getAllProduct())  // all
        for product in allData {
            if (product as! [String: Any])["product_name"] as? String == name {
                for project in (product as! [String: Any])["projects"] as! [[String: Any]]{
                    projects.append(project["project_name"] as! String)
                    for developer in project["developers"] as! [[String: Any]] {
                        developers.append(developer["developer_name"] as! String)
                        //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                    }
                }
            }
            
        }
        // 去重
        developers = filterRepeat(developers)
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    /* 项目选中，2 */
    func caseOne02(forProject name: String) {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        projects.append(contentsOf: getAllProject()) // all
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                if project["project_name"] as! String == name {
                    products.append((product as! [String: Any])["product_name"] as! String)
                    for developer in project["developers"] as! [[String: Any]]{
                        developers.append(developer["developer_name"] as! String)
                        //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                    }
                }
            }
            
        }
        // 去重
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    /* 开发选中，3 */
    func caseOne03(forDeveloper name: String) {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        developers.append(contentsOf: getAllDeveloper()) // all
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]] {
                    if developer["developer_name"] as! String == name {
                        products.append((product as! [String: Any])["product_name"] as! String)
                        projects.append(project["project_name"] as! String)
                        //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                    }
                }
            }
            
        }
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    /* bug级别选中，4 -> 0 */
    func caseOne04(forBugLevel name: String) {
        filterCaseDefault()
    }
    /*
    func caseOne04(forBugLevel name: String) {
        print("select bugLevl")
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        //bugLevels.append(contentsOf: getAllBugLevel())    // all
        bugLevels = getAllBugLevel()
        /* 使用for-in实现 */
//        for product in allData {
//            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
//                for developer in project["developers"] as! [[String: Any]] {
//                    let levels = developer["bug_levels"] as! [String]
//                    if levels.contains(name) {
//                        products.append((product as! [String: Any])["product_name"] as! String)
//                        projects.append(project["project_name"] as! String)
//                        developers.append(developer["developer_name"] as! String)
//                    }
//                }
//            }
//            
//        }
        /* 使用forEach实现 */
        allData.forEach { (product) in
            ((product as! [String: Any])["projects"] as! [[String: Any]]).forEach({ (project) in
                (project["developers"] as! [[String: Any]]).forEach({ (developer) in
                    let levels = developer["bug_levels"] as! [String]
                    if levels.contains(name) {
                        products.append((product as! [String: Any])["product_name"] as! String)
                        projects.append(project["project_name"] as! String)
                        developers.append(developer["developer_name"] as! String)
                    }

                })
            })
        }
        
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    
    // 合并4种参数情况
    func caseOne(forKey name: String, value: String) {
        
        switch name {
        case "product":
            //
            print("")
            caseOne01(forProduct: value)
        case "project":
            //
            print("")
            caseOne02(forProject: value)
        case "developer":
            //
            print("")
            caseOne03(forDeveloper: value)
        case "bugLevel":
            //
            print("")
            caseOne04(forBugLevel: value)
        default :
            print("")
        }
        
    }
    
    
    /* 选中2个，6种 （） */
    func filterCaseTwo() {
        let product = parameters["product"]
        let project = parameters["project"]
        let developer = parameters["developer"]
        let bugLevel = parameters["bugLevel"]
        
        // 12
        if product != "" && project != "" && developer == "" && bugLevel == "" {
            caseTwo01()
        }
        // 13
        if product != "" && project == "" && developer != "" && bugLevel == "" {
            caseTwo02()
        }
        // 14
        if product != "" && project == "" && developer == "" && bugLevel != "" {
            caseTwo03()
        }
        // 23
        if product == "" && project != "" && developer != "" && bugLevel == "" {
            caseTwo04()
        }
        // 24
        if product == "" && project != "" && developer == "" && bugLevel != "" {
            caseTwo05()
        }
        // 34
        if product == "" && project == "" && developer != "" && bugLevel != "" {
            caseTwo06()
        }
    }
    /* 12 */
    func caseTwo01() {
        var products: [String] = []     //
        var projects: [String] = []     //
        var developers: [String] = []   //
        var bugLevels: [String] = []    //
        
        for product in allData {
            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                products.append(parameters["product"]!)
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    projects.append(project["project_name"] as! String)     //当前产品包含所有项目
                    if project["project_name"] as? String == parameters["project"] {
                        for developer in project["developers"] as! [[String: Any]]{
                            developers.append(developer["developer_name"] as! String)
                            //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                        }
                    }
                }
            }
        }
        // 去重
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]

    }
        

    /* 13 */
    func caseTwo02() {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        for product in allData {
            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                products.append(parameters["product"]!)
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    for developer in project["developers"] as! [[String: Any]]{
                        developers.append(developer["developer_name"] as! String)   //当前产品包含所有开发
                        if developer["developer_name"] as? String == parameters["developer"] {
                            projects.append(project["project_name"] as! String)
                            //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                        }
                    }
                }
            }
        }
        // 去重
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]

    }
    /* 14 -> 1 */
    func caseTwo03() {
        caseOne01(forProduct: parameters["product"]!)
    }
    /*
    func caseTwo03() {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        for product in allData {
            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                products.append(parameters["product"]!)
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    for developer in project["developers"] as! [[String: Any]]{
                        for bugLevel in developer["bug_levels"] as! [String] {
                            bugLevels.append(contentsOf: developer["bug_levels"] as! [String])  //当前产品包含所有bugLevel
                            if bugLevel == parameters["bugLevel"] {
                                projects.append(project["project_name"] as! String)
                                developers.append(developer["developer_name"] as! String)
                            }
                        }
                    }
                }
            }
        }
        // 去重
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    /* 23 ???*/
    func caseTwo04() {
        var products: [String] = []     // 包含该项目和开发的所有产品
        var projects: [String] = []     // 包含该开发的所有项目
        var developers: [String] = []   // 该项目下所有开发
        var bugLevels: [String] = []    //
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if developer["developer_name"] as? String == parameters["developer"] {
                        projects.append(project["project_name"] as! String)     // 包含当前开发的所有项目
                    }
                }
                if project["project_name"] as? String == parameters["project"] {
                    products.append((product as! [String: Any])["product_name"] as! String) //
                    for developer in project["developers"] as! [[String: Any]]{
                        developers.append(developer["developer_name"] as! String)   // 当前项目下所有开发
                        if developer["developer_name"] as? String == parameters["developer"] {
                            //projects.append(project["project_name"] as! String)     // 包含当前开发的所有项目
                            //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                        }
                    }
                }
            }
        }
        // 去重
        projects = filterRepeat(projects)
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }

    
    /* 24 -> 2 */
    func caseTwo05() {
        caseOne02(forProject: parameters["project"]!)
    }
    /*
    func caseTwo05() {
        var products: [String] = []
        var projects: [String] = []
        var developers: [String] = []
        var bugLevels: [String] = []
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        projects.append(project["project_name"] as! String)     // 包含当前bugLevel的所有项目
                    }
                }
                if project["project_name"] as? String == parameters["project"] {
                    products.append((product as! [String: Any])["product_name"] as! String)
                    for developer in project["developers"] as! [[String: Any]]{
                        if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                            developers.append(developer["developer_name"] as! String)
                            bugLevels.append(contentsOf: developer["bug_levels"] as! [String]) // 当前项目下所有bugLevel
                        }
                    }
                }
            }
        }
        // 去重
        projects = filterRepeat(projects)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    /* 34 -> 3 */
    func caseTwo06() {
        caseOne03(forDeveloper: parameters["developer"]!)
    }
    /*
    func caseTwo06() {
        var products: [String] = []         // 同时包含该开发及bugLevel的所有产品
        var projects: [String] = []         // 同时包含该开发及bugLevel的所有项目
        var developers: [String] = []       // 包含该bugLevel的所有开发
        var bugLevels: [String] = []        // 包含该开发下的所有bugLevel
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if developer["developer_name"] as? String == parameters["developer"] && (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        products.append((product as! [String: Any])["product_name"] as! String)
                        projects.append(project["project_name"] as! String)
                    }
                    if developer["developer_name"] as? String == parameters["developer"] {
                        bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
                    }
                    if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        developers.append(developer["developer_name"] as! String)
                    }
                }
                
            }
        }
        // 去重
        projects = filterRepeat(projects)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    
    /* 选中3个，4种 （） */
    func filterCaseThree() {
        let product = parameters["product"]
        let project = parameters["project"]
        let developer = parameters["developer"]
        let bugLevel = parameters["bugLevel"]
        // .three
        if product != "" && project != "" && developer != "" && bugLevel == "" {
            caseThree01()
        }
        if product != "" && project != "" && developer == "" && bugLevel != "" {
            caseThree02()
        }
        if product != "" && project == "" && developer != "" && bugLevel != "" {
            caseThree03()
        }
        if product == "" && project != "" && developer != "" && bugLevel != "" {
            caseThree04()
        }

    }
    /* 123 */
    func caseThree01() {
        var products: [String] = []         // 同时包含该项目及开发的所有产品
        var projects: [String] = []         // 当前产品下包含该开发的所有项目
        var developers: [String] = []       // 当前产品及项目下的所有开发
        var bugLevels: [String] = []        // 当前开发下的所有bugLevel
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if project["project_name"] as? String == parameters["project"] && developer["developer_name"] as? String == parameters["developer"] {
                        products.append((product as! [String: Any])["product_name"] as! String) //
                    }
                    if developer["developer_name"] as? String == parameters["developer"] {
                        //bugLevels.append(contentsOf: developer["bug_levels"] as! [String])  //
                    }
                }
            }

            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    for developer in project["developers"] as! [[String: Any]]{
                        if developer["developer_name"] as? String == parameters["developer"] {
                            projects.append(project["project_name"] as! String) //
                        }
                    }
                    if project["project_name"] as? String == parameters["project"] {
                        for developer in project["developers"] as! [[String: Any]] {
                            developers.append(developer["developer_name"] as! String)   //
                        }
                    }
                }
            }
        }
        // 去重
        projects = filterRepeat(projects)
        //bugLevels = filterRepeat(bugLevels)
        bugLevels = getAllBugLevel()
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
        
    }
    /* 124 -> 12 */
    func caseThree02() {
        caseTwo01()
    }
    /*
    func caseThree02() {
        var products: [String] = []         // 同时包含该项目及bugLevel的所有产品
        var projects: [String] = []         // 当前产品下包含该bugLevel的所有项目
        var developers: [String] = []       // 当前产品及项目下包含该bugLevel的所有开发
        var bugLevels: [String] = []        // 当前项目下的所有bugLevel
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if project["project_name"] as? String == parameters["project"] && (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        products.append((product as! [String: Any])["product_name"] as! String) //
                    }
                    if project["project_name"] as? String == parameters["project"] {
                        for developer in project["developers"] as! [[String: Any]] {
                            bugLevels.append(contentsOf: developer["bug_levels"] as! [String])  //
                        }
                    }
                }
            }
            
            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    for developer in project["developers"] as! [[String: Any]]{
                        if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                            projects.append(project["project_name"] as! String) //
                        }
                    }
                    if project["project_name"] as? String == parameters["project"] {
                        for developer in project["developers"] as! [[String: Any]] {
                            if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                                developers.append(developer["developer_name"] as! String)   //
                            }
                        }
                    }
                }
            }
        }
        // 去重
        projects = filterRepeat(projects)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    /* 134 -> 13 */
    func caseThree03() {
        caseTwo02()
    }
    /*
    func caseThree03() {
        var products: [String] = []         // 同时包含该开发及bugLevel的所有产品
        var projects: [String] = []         // 当前产品下包含该开发及bugLevel的所有项目
        var developers: [String] = []       // 当前产品下包含该bugLevel的所有开发
        var bugLevels: [String] = []        // 当前产品下该开发下的所有bugLevel

        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                for developer in project["developers"] as! [[String: Any]]{
                    if developer["developer_name"] as? String == parameters["developer"] && (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        products.append((product as! [String: Any])["product_name"] as! String) //
                    }
                }
            }
            
            if (product as! [String: Any])["product_name"] as? String == parameters["product"] {
                for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                    for developer in project["developers"] as! [[String: Any]]{
                        if developer["developer_name"] as? String == parameters["developer"] && (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                            projects.append(project["project_name"] as! String) //
                        }
                        if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                            developers.append(developer["developer_name"] as! String)   //
                        }
                        if developer["developer_name"] as? String == parameters["developer"] {
                            bugLevels.append(contentsOf: developer["bug_levels"] as! [String])  //
                        }
                    }
                }
            }
        }
        // 去重
        projects = filterRepeat(projects)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    /* 234 -> 23 */
    func caseThree04() {
        caseTwo04()
    }
    /*
    func caseThree04() {
        var products: [String] = []         // 同时包含该项目的产品
        var projects: [String] = []         // 包含该开发及bugLevel的所有项目
        var developers: [String] = []       // 当前项目下包含该bugLevel的所有开发
        var bugLevels: [String] = []        // 当前项目下及该开发下的所有bugLevel
        
        for product in allData {
            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
                if project["project_name"] as? String == parameters["project"] {
                    products.append((product as! [String: Any])["product_name"] as! String) //
                    for developer in project["developers"] as! [[String: Any]]{
                        if (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                            developers.append(developer["developer_name"] as! String)   //
                        }
                        if developer["developer_name"] as? String == parameters["developer"] {
                            bugLevels.append(contentsOf: developer["bug_levels"] as! [String])  //
                        }
                    }
                }
                for developer in project["developers"] as! [[String: Any]]{
                    if developer["developer_name"] as? String == parameters["developer"] && (developer["bug_levels"] as! [String]).contains(parameters["bugLevel"]!) {
                        projects.append(project["project_name"] as! String) //
                    }
                }
                
            }
        }
        // 去重
        projects = filterRepeat(projects)
        bugLevels = filterRepeat(bugLevels)
        screeingDic = ["products": products, "projects": projects, "developers": developers, "bugLevels": bugLevels]
    }
    */
    
    
    /* 选中4个，1种 -> 不需要了（） */
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
//        var bugLevels: [String] = []
//        for product in allData {
//            for project in (product as! [String: Any])["projects"] as! [[String: Any]] {
//                for developer in project["developers"] as! [[String: Any]] {
//                    bugLevels.append(contentsOf: developer["bug_levels"] as! [String])
//                }
//            }
//        }
//        // 需要去重
//        /**
//         问题：中文怎么排序？？？
//        */
//        bugLevels = filterRepeat(bugLevels)
//        return bugLevels
        return ["一级", "二级", "三级", "四级"]
    }
    
    
    
    
    
    // 数组去重
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









