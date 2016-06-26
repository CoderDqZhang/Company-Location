//
//  MainViewController.swift
//  定位APP
//
//  Created by Jane on 11/18/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import MJExtension
import SwiftyJSON
import MJRefresh

let mainViewCell = "mainViewCell"

func getArticalArray(modelArray: [JSON]) -> NSMutableArray {
    let articalArray = NSMutableArray()
    for model in modelArray{
        let artical = ArticalModel()
        artical.pos = model["pos"].stringValue
        artical.date = model["date"].stringValue
        artical.photo = Photo.mj_objectWithKeyValues(model["photo"].arrayObject![0])
        artical.zipPhoto = ZipPhoto.mj_objectWithKeyValues(model["zipPhoto"].arrayObject![0])
        articalArray.addObject(artical)
    }
    return articalArray
}

class MainViewController: UIViewController {
    
    var tableView:ManageTable!
    var staffTable:StaffTableView!
    
    var imagePicker =  UIImagePickerController()
    var articleArray:NSMutableArray!
    var articlaModel:ArticalModel!
    var photo:Photo!
    var page:NSInteger!
    var buttonView:Button!
    
    var datatime:UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        page = 1;
        self.title = "位置信息"
        self.navigationController?.navigationBar.translucent = false
        self.articleArray = NSMutableArray()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.createMainView()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home_leftbt"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("leftBtClick:"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: Selector("rightBtClick:"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMJRefresh(){
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock:{
            self.loadData()
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadMoreData()
        })
        self.loadData()
    }
    
    func loadData(){
        self.getPhoto(page)
    }
    
    func loadMoreData(){
        page = page + 1
        self.getPhoto(page)
    }
    
    func leftBtClick(sender:UIBarButtonItem){
        print("left Bt is Click");
        self.slideMenuController()?.openLeft()
        
    }
    
    func rightBtClick(sender:UIBarButtonItem){
        self.takePhoto()
        
    }
    
    func createMainView(){
        let userDefalus = NSUserDefaults.standardUserDefaults()
        let isLogin = userDefalus.boolForKey("isLogin")
        if isLogin == false
        {
            self.loginBtShow()
        }else{
            if isLogin {
                buttonView = Button()
                buttonView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40)
                buttonView.createView()
                buttonView.starTime .addTarget(self, action: Selector("createDatePick:"), forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(buttonView)
                tableView = ManageTable(frame: CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
                tableView.getPhoto(1,number: "",startTime: "",endTime: "")
                tableView.createMJRefresh()
                tableView.delegate = tableView;
                tableView.dataSource = tableView;
                self.view.addSubview(tableView)
                
            }else{
                staffTable = StaffTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
                staffTable.loadData()
                staffTable.delegate = staffTable
                staffTable.dataSource = staffTable
                staffTable.createMJRefresh()
                self.view.addSubview(staffTable)
            }
            
        }
        
    }
    
    func createDatePick(sender:UIDatePicker){
        let actionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil)
        datatime = UIDatePicker(frame: CGRectMake(0, UISCREEN_HEIGHT-316, UISCREEN_WIDTH, 316))
        datatime.backgroundColor = UIColor.whiteColor();
        //    指定Delegate
        datatime.tag = 100
        datatime.datePickerMode = UIDatePickerMode.DateAndTime
        datatime.minuteInterval = 30
        
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, UISCREEN_WIDTH, 44))
        let toolBarItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: Selector("datetimeClick:"))
        toolBar.items = [toolBarItem]
        actionSheet.adds
        self.view.addSubview(datatime)
    }
    
    func loginBtShow(){
        let loginViewController = BaseNavigationController(rootViewController: LoginViewController())
        loginViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    func takePhoto(){
        let sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)//进入照相界面
    }
    
    
    func getPhoto(page:NSInteger) {
        let pageNumber = NSString(format: "\(page)")
        Alamofire.request(.GET, GetPhotoUrl, parameters: ["page":pageNumber])
            .responseJSON { response in
                print(response.result.value)
                var json = JSON(response.result.value!)
                let articalArray = json["artical"].arrayValue
                let code = json["code"].stringValue
                if (code == "success"){
                    self.articleArray.addObjectsFromArray(getArticalArray(articalArray) as [AnyObject])
                    self.tableView.reloadData()
            }
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
        }
    }
    
    lazy var Articals: NSMutableArray = {
        var array = NSMutableArray()
        for m_artical in self.articleArray{
            array.addObject(m_artical as! ArticalModel)
        }
        return array
    }()
}


extension MainViewController : UITableViewDelegate{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 50
        }else if indexPath.row == 1{
            return UISCREEN_WIDTH
        }else{
           return 50
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == 0{
            let userInfoView = UserViewController()
            self.navigationController?.pushViewController(userInfoView, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
}

extension MainViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.articleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let artical = self.Articals[indexPath.section] as! ArticalModel
        
        if indexPath.row == 0{
            let cell = UITableViewCell(style:.Default, reuseIdentifier:"myCell")
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel!.text = artical.date as String
            return cell
        }else if(indexPath.row == 1){
            let cellIndentifier :String = "ImageCell";
            var cell:MainTableViewcell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? MainTableViewcell
            if cell == nil{
                cell = MainTableViewcell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIndentifier)
            }
            if artical.zipPhoto.path != ""{
                cell?.setData(artical.zipPhoto.path)
            }
            return cell!
        }else{
            let cell = UITableViewCell(style:.Default, reuseIdentifier:"LocationCell")
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel!.text = artical.pos as String
            return cell
        }
    }    
}


extension MainViewController : UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let senderLocationView = SenderLocationViewController()
        let baseViewController = BaseNavigationController(rootViewController:senderLocationView)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePicker.dismissViewControllerAnimated(true, completion: {
            
        })
        senderLocationView.image = image
        self.presentViewController(baseViewController, animated: true, completion: nil)
    }
}

extension MainViewController : UINavigationControllerDelegate{
    
}



