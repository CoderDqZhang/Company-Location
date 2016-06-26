//
//  SenderLocationViewController.swift
//  定位APP
//
//  Created by Jane on 11/22/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire

let UISCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let UISCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

class SenderLocationViewController: UIViewController {

    var locationManager:AMapLocationManager!
    var completionBlock:AMapLocatingCompletionBlock!
    
    var tableView:UITableView!
    var image:UIImage!
    var location:NSString!
    var alertController:UIAlertController!
    var imagePicker =  UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location = "正在搜索地理信息位置"
        self.initTableView()
        self.locationManager = AMapLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        self.initNavigation()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getLocation()
    }
    
    func initTableView(){
        self.tableView = UITableView(frame: CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    func initNavigation(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: Selector("leftBtClick:"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: Selector("rightBtClick:"))
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    

    func initAlerViewController(){
        self.alertController = UIAlertController(title: "提示", message: "确定要退出此次编辑吗？", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) in
        self.alertController.canResignFirstResponder()
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "确定", style: .Default) { (action) in
        self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        
        }
    }
    
    
    func takePhoto(){
        var sourceType = UIImagePickerControllerSourceType.Camera
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.presentViewController(imagePicker, animated: true, completion: nil)//进入照相界面
    }
    
    
    
    func leftBtClick(sender:UIBarButtonItem){
        self.initAlerViewController()
    }
    
    
    func rightBtClick(sender:UIBarButtonItem){
        self.senderLocation(self.image, pos: self.location)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation(){
        self.locationManager .requestLocationWithReGeocode(true, completionBlock:{(location,regeocode, error) in
            if (error != nil)
            {
                print("locError:{%ld - %@};", error.code, error.localizedDescription);
                TTAlertNoTitle(error.localizedDescription)
                return
            }else{
                if (regeocode != nil)
                {
                    self.reloadData(regeocode.formattedAddress)
                    print("reGeocode:%@", regeocode);
                    
                }
            }
       })
    }
    
    
    func reloadData(location:NSString){
        self.location = location;
        self.tableView.reloadData()
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func senderLocation(image:UIImage!, pos:NSString!){
        Alamofire.upload(
            .POST,
            UploadPhotoUrl,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: pos.dataUsingEncoding(NSUTF8StringEncoding)!, name: "pos")
                let imageData = UIImageJPEGRepresentation(image!, 0.75)
                let date:NSDate = NSDate()
                let formatter:NSDateFormatter = NSDateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let dateString = formatter.stringFromDate(date)
                multipartFormData.appendBodyPart(data: imageData!, name: "photo", fileName: "\(dateString).JPEG", mimeType: "image/JPEG")
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                    self.dismissViewControllerAnimated(true, completion: nil)
                case .Failure(let encodingError):
                    print(encodingError)
                }
            })
        }
}

extension SenderLocationViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        if indexPath.row == 0{
            return UISCREEN_WIDTH
        }else{
            return 44
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}


extension SenderLocationViewController : UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.row == 0{
            let cellIndentifier :String = "ImageCell";
            var cell:ImageTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIndentifier) as? ImageTableViewCell
            if cell == nil{
                cell = ImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIndentifier)
             }
            cell!.photoView.image = self.image
            return cell!
        }else{
            let cell = UITableViewCell(style:.Default, reuseIdentifier:"LocationCell")
            cell.textLabel!.text = self.location as String
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            return cell
        }
    }
}

extension SenderLocationViewController : UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        self.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.tableView.reloadData()
        imagePicker.dismissViewControllerAnimated(true, completion: {
            
        })
    }
}

extension SenderLocationViewController : UINavigationControllerDelegate{
    
}
