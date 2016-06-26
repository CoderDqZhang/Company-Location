//
//  LeftViewController.swift
//  定位APP
//
//  Created by Jane on 11/18/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JSONJoy
import SDWebImage
import MJExtension

let kBtwidth:CGFloat = 70

class LeftViewController: UIViewController {

    var photoImage:UIImageView!
    var tableView:UITableView!
    var infoArray:NSMutableArray!
    var userInfoArray:NSMutableArray!
    
    var userInfo:UserInfos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoArray = NSMutableArray(objects: "昵称:","职位:","部门:","简介:")
//        self.view.addSubview(self.cratePhotoImage())
        self.view.backgroundColor = UIColor.whiteColor()
        self.crateTableView()
        
        // Do any additional setup after loading the view.
    }
    
    func crateTableView(){
        self.tableView = UITableView(frame: CGRectMake(0, 0, 200, UISCREEN_HEIGHT), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let userDefalus = NSUserDefaults.standardUserDefaults()
        let isLogin = userDefalus.boolForKey("isLogin")
        if isLogin == true
        {
            self.getUserInfo(NSUserDefaults.standardUserDefaults().objectForKey("uid") as! String)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cratePhotoImage() -> UIImageView{
        photoImage = UIImageView(frame: CGRectMake((200-kBtwidth)/2, 50, kBtwidth, kBtwidth))
        photoImage.userInteractionEnabled = true
        let singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "userInfo:")
        photoImage .addGestureRecognizer(singleTap)
        return photoImage
    }
    
    func userInfo(sender:UITapGestureRecognizer){
        
    }
    
    func getUserInfo(uid:NSString){
        Alamofire.request(.GET, GetUserInfoUrl, parameters: ["userNum":"00000002"])
            .responseJSON { response in
                print(response.result.value!)
                self.userInfo = UserInfos.mj_objectWithKeyValues(response.result.value!)
                if (self.userInfo.code == "success"){
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                        print("\(ImageUrl)\(self.userInfo.inf!.headImg)")
                        let data = NSData(contentsOfURL: NSURL(string: "\(ImageUrl)\(self.userInfo.inf!.headImg)")!)
                        var image = UIImage()
                        if data != nil{
                            image = UIImage(data: data!)!
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            self.photoImage.image = image
                        })
                    })
                    self.userInfoArray = NSMutableArray()
                    self.userInfoArray.addObject(self.userInfo.inf!.name)
                    self.userInfoArray.addObject(self.userInfo.inf!.role)
                    self.userInfoArray.addObject(self.userInfo.inf!.department)
                    self.userInfoArray.addObject(self.userInfo.inf!.intro)
                    self.tableView.reloadData()
                }
        }
 
    }
    
    
    lazy var CellArray: NSMutableArray = {
        var array = NSMutableArray()
        if self.userInfo != nil{
            array.addObject(self.userInfo.inf!.name)
            array.addObject(self.userInfo.inf!.role)
            array.addObject(self.userInfo.inf!.department)
            array.addObject(self.userInfo.inf!.intro)
        }else{
            array.addObjectsFromArray(self.infoArray as [AnyObject])
        }
        return array
    }()
    
}

extension LeftViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 160
        }else{
            return 30
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let headerView = UIView(frame: CGRectMake(0, 0, 200, 200))
            headerView.addSubview(self.cratePhotoImage())
            return headerView
        }else{
            return nil
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style:.Value1, reuseIdentifier:"userInfoCell")
        cell.textLabel!.text = infoArray.objectAtIndex(indexPath.row) as? String
        if self.userInfoArray != nil {
            cell.detailTextLabel?.text = self.userInfoArray.objectAtIndex(indexPath.row) as? String
        }
        
        return cell
    }
    
}