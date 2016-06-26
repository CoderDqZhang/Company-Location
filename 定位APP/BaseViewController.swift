//
//  BaseViewController.swift
//  定位APP
//
//  Created by Jane on 11/19/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var userName:UITextField!
    var verificationCode:UITextField!
    var nextStep:UIButton!
    var getCode:UIButton!
    var timeLable:UILabel!
    var timeNow:NSTimer!
    var count:Int = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.createView()
        // Do any additional setup after loading the view.
    }
    
    func createView(){
        self.navigationController?.navigationBar.translucent = false
        self.view.addSubview(self.creatUserName())
        self.view.addSubview(self.createPassWord())
        self.view.addSubview(self.createCode())
        self.view.addSubview(self.createTimeLable())
        self.view.addSubview(self.createnextStep())
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: Selector("leftBtClick:"))
    }
    
    func creatUserName()->UITextField{
        let leftImg_User:UIImageView = UIImageView(image: UIImage(named: "ic_login_phone")!)
        leftImg_User.frame = CGRect(x: 15, y: 5, width: 20, height: 20)
        leftImg_User.contentMode = UIViewContentMode.ScaleAspectFit
        userName = UITextField(frame: CGRectMake(20, 30, self.view.frame.size.width-40, 40))
        userName.borderStyle = UITextBorderStyle.RoundedRect
        userName.placeholder = "请输入电话号码"
        userName.keyboardType = UIKeyboardType(rawValue: 4)!
        userName.returnKeyType = UIReturnKeyType(rawValue: 0)!
        userName.delegate = self
        userName.clearButtonMode =  UITextFieldViewMode.WhileEditing
        userName.leftView = leftImg_User
        userName.leftViewMode = UITextFieldViewMode.Always
        //        userName.leftViewRectForBounds(CGRect(x: 0, y: 0, width: 30, height: 30))
        return userName
    }
    
    func createPassWord()->UITextField{
        let leftImg_PassWord:UIImageView = UIImageView(image: UIImage(named: "ic_login_code")!)
        leftImg_PassWord.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        leftImg_PassWord.contentMode = UIViewContentMode.ScaleAspectFit
        
        verificationCode = UITextField(frame:CGRectMake(userName.frame.origin.x, userName.frame.size.height+userName.frame.origin.y+10, self.view.frame.size.width-40-100, 40))
        verificationCode.borderStyle = UITextBorderStyle.RoundedRect
        verificationCode.placeholder = "验证码"
        
        verificationCode.keyboardType = UIKeyboardType(rawValue:4)!
        verificationCode.returnKeyType = UIReturnKeyType(rawValue: 0)!
        verificationCode.delegate = self
        verificationCode.clearButtonMode =  UITextFieldViewMode.WhileEditing
        verificationCode.leftView = leftImg_PassWord
        verificationCode.leftViewMode = UITextFieldViewMode.Always
        //        password.leftViewRectForBounds(CGRect(x: 0, y: 0, width: 40, height: 40))
        return verificationCode
    }
    func createTimeLable()->UILabel{
        
        timeLable = UILabel(frame:CGRectMake(self.view.frame.size.width-100-userName.frame.origin.x, verificationCode.frame.origin.y, 100, 40))
        timeLable.hidden = true
        timeLable.textColor = UIColor.whiteColor()
        timeLable.textAlignment = NSTextAlignment.Center
        timeLable.backgroundColor = UIColor ( red: 0.37, green: 1.0, blue: 0.71, alpha: 1.0 )
        return timeLable
    }
    
    func createCode()->UIButton{
        getCode = UIButton(type: UIButtonType.Custom)
        getCode.setTitle("获取验证码", forState: UIControlState.Normal)
        getCode.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        getCode.addTarget(self, action: Selector("getValue:"), forControlEvents: UIControlEvents.TouchUpInside)
        getCode.frame = CGRectMake(self.view.frame.size.width-100-userName.frame.origin.x, verificationCode.frame.origin.y, 100, 40)
        getCode.backgroundColor = UIColor ( red: 0.37, green: 1.0, blue: 0.71, alpha: 1.0 )
        
        return getCode
    }
    
    
    func createnextStep()->UIButton{
        nextStep = UIButton(type: UIButtonType.Custom)
        nextStep.frame = CGRectMake(userName.frame.origin.x, verificationCode.frame.size.height+verificationCode.frame.origin.y+10, userName.frame.size.width, 40)
        nextStep.setTitle("下一步", forState: UIControlState.Normal)
        
        nextStep.addTarget(self, action: Selector("nextStep:"), forControlEvents: UIControlEvents.TouchUpInside)
        nextStep.backgroundColor = UIColor ( red: 0.37, green: 1.0, blue: 0.71, alpha: 1.0 )
        return nextStep
    }
    
    func timeDow()
    {
        let time1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: "updateTime", userInfo: nil, repeats: true)
        timeNow = time1
    }
    
    func showRepeatButton()
    {
        timeLable.hidden=true
        getCode.hidden = false
        getCode.enabled = true
    }
    
    func updateTime()
    {
        count--
        if (count <= 0)
        {
            count = 60
            self.showRepeatButton()
            timeNow.invalidate()
        }
        timeLable.text = "倒计时\(count)S"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftBtClick(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getValue(sender:UIButton){
        
        if self.isTelNumber(userName.text!){
            getCode.hidden = true
            timeLable.hidden = false
            self.timeDow()
            self .senderMessage(userName.text!)
        }else{
            TTAlertNoTitle("手机号码不正确")
        }
    }
    
    func senderMessage(phoneNumber:NSString){
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: phoneNumber as String, zone: "86", customIdentifier: nil, result:{error in
            
            print("error----  \(error)")
            if (error == nil){
                print("获取验证码成功");
            }else{
                print("获取验证码失败")
            }
        });
    }
    
    func nextStep(sender:UIButton){
        
        
    }
    
    func isTelNumber(num:NSString)->Bool
    {
        let pred = NSPredicate(format:"SELF MATCHES %@", "^1(3|5|7|8|4)\\d{9}")
        return pred.evaluateWithObject(num)
    }
}

extension BaseViewController : UITextFieldDelegate{
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == verificationCode
        {
            verificationCode.resignFirstResponder()
            return true
            
        }else{
            
            userName.resignFirstResponder()
            return true;
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
    }

}
