//
//  LoginViewController.swift
//  定位APP
//
//  Created by Jane on 11/18/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    var userName:UITextField!
    var password:UITextField!
    var loginBt:UIButton!
    var titleLabel:UILabel!
    var registerBt:UIButton!
    var forgetPasswordBt:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        self.view.backgroundColor = UIColor.whiteColor()
        titleLabel = UILabel(frame: CGRectMake(20, 69,self.view.frame.size.width-40, 30))
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.text = "为了防止用户信息被盗用，请使用本机号码登录"
        self.view .addSubview(titleLabel)
        self.view.addSubview(self.careUserName())
        self.view.addSubview(self.createPassWord())
        self.view.addSubview(self.createLoginBt())
        //不用注册按钮
        //self.view.addSubview(self.createRegisterBt())
        //不用忘记密码按钮
        //self.view.addSubview(self.createforgetPasswordBt())
        // Do any additional setup after loading the view.
    }

    func careUserName()->UITextField{
        let leftImg_User:UIImageView = UIImageView(image: UIImage(named: "ic_login_phone")!)
        leftImg_User.frame = CGRect(x: 15, y: 5, width: 20, height: 20)
        leftImg_User.contentMode = UIViewContentMode.ScaleAspectFit
        userName = UITextField(frame: CGRectMake(20, titleLabel.frame.size.height+titleLabel.frame.origin.y+10, self.view.frame.size.width-40, 40))
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
        
        password = UITextField(frame:CGRectMake(userName.frame.origin.x, userName.frame.size.height+userName.frame.origin.y+10, self.view.frame.size.width-40, 40))
        password.borderStyle = UITextBorderStyle.RoundedRect
        password.secureTextEntry = true;
        password.placeholder = "密码"
//        password.keyboardType = UIKeyboardType(rawValue:4)!
        password.returnKeyType = UIReturnKeyType(rawValue: 0)!
        password.delegate = self
        password.delegate = self
        password.clearButtonMode =  UITextFieldViewMode.WhileEditing
        password.leftView = leftImg_PassWord
        password.leftViewMode = UITextFieldViewMode.Always
//        password.leftViewRectForBounds(CGRect(x: 0, y: 0, width: 40, height: 40))
        return password
    }
    
    
    func createLoginBt()->UIButton{
        loginBt = UIButton(type: UIButtonType.Custom)
        loginBt.frame = CGRectMake(userName.frame.origin.x, password.frame.size.height+password.frame.origin.y+10, userName.frame.size.width, 40)
        loginBt.setTitle("登录", forState: UIControlState.Normal)
        loginBt.addTarget(self, action: Selector("Login:"), forControlEvents: UIControlEvents.TouchUpInside)
        loginBt.backgroundColor = UIColor ( red: 0.37, green: 1.0, blue: 0.71, alpha: 1.0 )
        return loginBt
    }
    /*
    /**
     创建注册账号按钮(不用)
     
     - returns: button
     */
    func createRegisterBt()->UIButton{
        registerBt = UIButton(type: UIButtonType.Custom)
        registerBt.frame = CGRectMake(self.view.frame.size.width/2-80, loginBt.frame.size.height+loginBt.frame.origin.y+10, 80, 40)
        registerBt.setTitle("注册账号", forState: UIControlState.Normal)
        registerBt.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        registerBt.addTarget(self, action: Selector("registerClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        registerBt.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        registerBt.backgroundColor = UIColor.clearColor()
        return registerBt
    }
    /**
     创建忘记密码按钮(不用)
     
     - returns: button
     */
    func createforgetPasswordBt()->UIButton{
        forgetPasswordBt = UIButton(type: UIButtonType.Custom)
        forgetPasswordBt.frame = CGRectMake(self.view.frame.size.width/2+20, loginBt.frame.size.height+loginBt.frame.origin.y+10, 60, 40)
        forgetPasswordBt.setTitle("忘记密码", forState: UIControlState.Normal)
        forgetPasswordBt.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        forgetPasswordBt.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        forgetPasswordBt.addTarget(self, action: Selector("forgetPasswordClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        forgetPasswordBt.backgroundColor = UIColor.clearColor()
        return forgetPasswordBt
    }
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消",style:UIBarButtonItemStyle.Done , target: self, action: Selector("leftBtClick:"))
    }
    
    func leftBtClick(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: {
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    /**
     注册功能不用
     
     - parameter sender: <#sender description#>
     */
    func registerClick(sender:UIButton){
        let register = RegisterViewController()
        let registerView = BaseNavigationController(rootViewController:register)
        self.presentViewController(registerView, animated: true, completion: nil)
    }
    /**
     忘记密码功能也不用
     
     - parameter sender: <#sender description#>
     */
    
    func forgetPasswordClick(sender:UIButton){
        let forgetPass = ForgetPassViewController()
        let registerView = BaseNavigationController(rootViewController:forgetPass)
        self.presentViewController(registerView, animated: true, completion: nil)
    }
    */
    func Login(loginBt:UIButton)
    {
        if isImpt(){
            self.loginUser(self.userName.text, password:self.password.text)
        }
    }
    
    func isImpt()->Bool{
        var ret = false
        if userName.text == nil{
            TTAlertNoTitle("请输入账号")
        }else if password.text == nil{
            TTAlertNoTitle("请输入密码")
        }else{
            ret = true
        }
        return ret
    }
    func loginUser(phone:NSString!, password:NSString!){
        print("phone \(phone) password \(password)")
        Alamofire.request(.POST, MobileLoginUrl, parameters: ["username": phone!,"password": password])
            .responseJSON { response in
                var json = JSON(response.result.value!)
                print(json)
                let uid = json["userNum"].stringValue
                let code = json["code"].stringValue
                print(code)
                if code == "success"
                {
                    let userDefaluts = NSUserDefaults.standardUserDefaults()
                    userDefaluts.setObject(uid, forKey: "uid")
                    userDefaluts.setBool(true, forKey: "isLogin")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITextFieldDelegate{
    
}

