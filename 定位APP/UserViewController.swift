//
//  UserViewController.swift
//  定位APP
//
//  Created by Jane on 11/25/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController {

    var tableView:UITableView!
    var titleArray:NSArray!
    var userInfo:UserInfos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        self.navigationItem.backBarButtonItem?.title = "返回"
        self.view.backgroundColor = UIColor.whiteColor()
        titleArray = NSArray(objects: "角色信息","基本信息","部门信息")
        self.createTableView()
        // Do any additional setup after loading the view.
    }
    
    func createTableView(){
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getUserInfo(uid:NSString){
        Alamofire.request(.GET, GetUserInfoUrl, parameters: ["userNum":uid])
            .responseJSON { response in
                self.userInfo = UserInfos.mj_objectWithKeyValues(response.result.value!)
                if (self.userInfo.code == "success"){
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                        print("\(ImageUrl)\(self.userInfo.inf!.headImg)")
//                        let data = NSData(contentsOfURL: NSURL(string: "\(ImageUrl)\(self.userInfo.inf!.headImg)")!)
//                        var image = UIImage()
//                        if data != nil{
//                            image = UIImage(data: data!)!
//                        }
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.photoImage.image = image
//                        })
//                    })
                    self.tableView.reloadData()
                }
        }
        
    }
}

extension UserViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 44
    }
}

extension UserViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titleArray.objectAtIndex(section) as? String
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style:.Default, reuseIdentifier:"UserInfoCell")
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel!.text = "this is test"
        return cell
    }
}



