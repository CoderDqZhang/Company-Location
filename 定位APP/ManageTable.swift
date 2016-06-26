//
//  ManageTable.swift
//  定位APP
//
//  Created by Jane on 11/30/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire
import MJExtension
import SwiftyJSON

typealias getStaffNumber = (String) -> String

class ManageTable: UITableView {
    var numberRow:Int!
    var heightForRow:CGFloat!
    var articleArray:NSMutableArray!
    var blockProperty : () -> String = { return ""/**/} // 带初始化方式
    var staffNumber : getStaffNumber?
    
    func createMJRefresh(){
        self.mj_header = MJRefreshNormalHeader(refreshingBlock:{
            self.loadData()
        })
        self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadMoreData()
        })
        self.loadData()
    }
    
    func loadData(){
        
    }
    
    func loadMoreData(){
        
    }
    
    
    func getPhoto(page:NSInteger,number:NSString,startTime:NSString,endTime:NSString) {
        let pageNumber = NSString(format: "\(page)")
        self.articleArray = NSMutableArray()
        Alamofire.request(.POST, GetCheckPhotoUrl, parameters: ["page":pageNumber,"number":pageNumber,"startTime":pageNumber,"endTime":pageNumber,])
            .responseJSON { response in
                print(response.result.value)
                var json = JSON(response.result.value!)
                let articalArray = json["artical"].arrayValue
                let code = json["code"].stringValue
                if (code == "success"){
                    self.articleArray.addObjectsFromArray(getArticalArray(articalArray) as [AnyObject])
                    self.reloadData()
                }
                self.mj_header.endRefreshing()
                self.mj_footer.endRefreshing()
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

extension ManageTable : UITableViewDelegate{
    
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
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
//        if indexPath.row == 0{
//            let userInfoView = UserViewController()
//            self.navigationController?.pushViewController(userInfoView, animated: true)
//        }
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//    }
    
}

extension ManageTable : UITableViewDataSource {
    
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