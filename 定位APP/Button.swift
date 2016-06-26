//
//  Button.swift
//  定位APP
//
//  Created by Jane on 11/30/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import MJExtension
import SwiftyJSON

class Button: UIView {
    var downBt:UIButton!
    var centerLine:UIButton!
    var starTime:UIButton!
    var endTime:UIButton!
    var downListView:PopoverView!
    var downListView1:PopoverView!
    var staffNumber:NSMutableArray!
    var datatime:UIDatePicker!
    var datatime1:UIDatePicker!
    var toolBar:UIToolbar!
    
    func createView(){
        self.staffNumber = NSMutableArray()
        self.getStaff("11")
        self.createBt()
        self.createDatePicker()
    }
    
    func createBt(){
        self.downBt = UIButton(type: UIButtonType.Custom)
        self.downBt.frame = CGRectMake(0, 0, UISCREEN_WIDTH/3-4, 40)
        self.downBt.tag = 0
        self.downBt.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.downBt.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.downBt.setTitle("员工编号", forState: UIControlState.Normal)
        self.addSubview(self.downBt)
        
        let centerLine = UILabel(frame: CGRectMake(UISCREEN_WIDTH/3-1, 0, 2, 40))
        centerLine.backgroundColor = UIColor.grayColor()
        self.addSubview(centerLine)
        
        self.starTime = UIButton(type: UIButtonType.Custom)
        self.starTime.frame = CGRectMake(UISCREEN_WIDTH/3-3, 0, UISCREEN_WIDTH/3-4, 40)
        self.starTime.setTitle("开始时间", forState: UIControlState.Normal)
        self.starTime.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.starTime.tag = 1
//        self.starTime.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.starTime)
        
        let centerLine1 = UILabel(frame: CGRectMake(UISCREEN_WIDTH-UISCREEN_WIDTH/3-2, 0, 2, 40))
        centerLine1.backgroundColor = UIColor.grayColor()
        self.addSubview(centerLine1)
        
        self.endTime = UIButton(type: UIButtonType.Custom)
        self.endTime.frame = CGRectMake(UISCREEN_WIDTH-UISCREEN_WIDTH/3, 0, UISCREEN_WIDTH/3-4, 40)
        self.endTime.setTitle("结束时间", forState: UIControlState.Normal)
        self.endTime.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.endTime.tag = 2
//        self.endTime.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.endTime)
    }
    
    
    func buttonClick(sender:UIButton){
        if sender.tag == 0{
            self.createDownListView(sender)
        }else{
            self.createDatePicker()
        }
    }
    
    func createDatePicker(){
            //close all keyboard or data picker visible currently
        print("buttonclick")
        datatime = UIDatePicker(frame: CGRectMake(0, UISCREEN_HEIGHT-216, UISCREEN_WIDTH, 216))
        datatime.backgroundColor = UIColor.blackColor();
        //    指定Delegate
        datatime.tag = 100
        datatime.datePickerMode = UIDatePickerMode.DateAndTime
        datatime.minuteInterval = 30
        let toolBar = UIToolbar(frame: CGRectMake(0, 0, UISCREEN_WIDTH, 44))
        let toolBarItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: Selector("datetimeClick:"))
        toolBar.items = [toolBarItem]
        self.addSubview(datatime)
    }
    
    func datetimeClick(sender:UIDatePicker){
        let selectDate = sender.date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-mm-dd HH:mm"
        let dateString = formatter.stringFromDate(selectDate)
        print(dateString)
        
    }
    
    func createDownListView(sender:UIButton){
        let point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height + 60)
        self.downListView = PopoverView(point: point, titles: self.staffNumber as [AnyObject], images: nil)
        self.downListView.selectRowAtIndex = { index in
            print(self.staffNumber.objectAtIndex(index))
            self.downBt.setTitle("员工编号:\(self.staffNumber.objectAtIndex(index))", forState: UIControlState.Normal)
        }
        self.downListView.show()
        
    }
    
    func createDownListView1(sender:UIButton){
        
        
    }
    
    
    func getStaff(depart:NSString!){
        Alamofire.request(.GET, GetStaff, parameters: ["depart":depart])
            .responseJSON { response in
                print(response.result.value)
                var json = JSON(response.result.value!)
                let memberArray = json["member"].arrayObject
                let staffArray = Member.mj_objectArrayWithKeyValuesArray(memberArray)
                self.getStaffNumber(staffArray)
                
        }
    }
    
    func getStaffNumber(staffArray:NSMutableArray){
        for info in staffArray{
           let member = info as! Member
           self.staffNumber.addObject(member.number )
        }
        
    }
}
