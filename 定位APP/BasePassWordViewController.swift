//
//  BasePassWordViewController.swift
//  定位APP
//
//  Created by Jane on 11/19/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class BasePassWordViewController: UIViewController {

    var phoneNumber:NSString!
    var password:UITextField!
    var verificaPassword:UITextField!
    var nextStep:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.createPassWord())
        self.view.addSubview(self.createverificaPassword())
        self.view.addSubview(self.createnextStepBt())
        // Do any additional setup after loading the view.
    }

    func createPassWord()->UITextField{
        let leftImg_PassWord:UIImageView = UIImageView(image: UIImage(named: "ic_login_code")!)
        leftImg_PassWord.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        leftImg_PassWord.contentMode = UIViewContentMode.ScaleAspectFit
        
        password = UITextField(frame:CGRectMake(20, 30, self.view.frame.size.width-40, 40))
        password.borderStyle = UITextBorderStyle.RoundedRect
        password.placeholder = "密码"
        password.keyboardType = UIKeyboardType(rawValue:4)!
        password.returnKeyType = UIReturnKeyType(rawValue: 0)!
        password.delegate = self
        password.clearButtonMode =  UITextFieldViewMode.WhileEditing
        password.leftView = leftImg_PassWord
        password.leftViewMode = UITextFieldViewMode.Always
        //        password.leftViewRectForBounds(CGRect(x: 0, y: 0, width: 40, height: 40))
        return password
    }
    
    func createverificaPassword()->UITextField{
        let leftImg_PassWord:UIImageView = UIImageView(image: UIImage(named: "ic_login_code")!)
        leftImg_PassWord.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        leftImg_PassWord.contentMode = UIViewContentMode.ScaleAspectFit
        
        verificaPassword = UITextField(frame:CGRectMake(password.frame.origin.x, password.frame.size.height+password.frame.origin.y+10, self.view.frame.size.width-40, 40))
        verificaPassword.borderStyle = UITextBorderStyle.RoundedRect
        verificaPassword.placeholder = "确认密码"
        verificaPassword.keyboardType = UIKeyboardType(rawValue:4)!
        verificaPassword.returnKeyType = UIReturnKeyType(rawValue: 0)!
        verificaPassword.delegate = self
        verificaPassword.clearButtonMode =  UITextFieldViewMode.WhileEditing
        verificaPassword.leftView = leftImg_PassWord
        verificaPassword.leftViewMode = UITextFieldViewMode.Always
        //        password.leftViewRectForBounds(CGRect(x: 0, y: 0, width: 40, height: 40))
        return verificaPassword
    }
    
    
    func createnextStepBt()->UIButton{
        nextStep = UIButton(type: UIButtonType.Custom)
        nextStep.frame = CGRectMake(verificaPassword.frame.origin.x, verificaPassword.frame.size.height+verificaPassword.frame.origin.y+10, verificaPassword.frame.size.width, 40)
        nextStep.addTarget(self, action: Selector("nextStep:"), forControlEvents: UIControlEvents.TouchUpInside)
        nextStep.backgroundColor = UIColor ( red: 0.37, green: 1.0, blue: 0.71, alpha: 1.0 )
        return nextStep
    }
    
    func nextStep(sender:UIButton){
        
    }
    
    func isSuccess()->Bool{
        var ret = false
        if password.text == verificaPassword.text{
            ret = true
        }
        return ret
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension BasePassWordViewController : UITextFieldDelegate{
    
    
}