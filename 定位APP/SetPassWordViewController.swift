//
//  SetPassWordViewController.swift
//  定位APP
//
//  Created by Jane on 11/19/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class SetPassWordViewController: BasePassWordViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置密码"
        super.nextStep.setTitle("注册", forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func nextStep(sender: UIButton) {
        if super.isSuccess(){
            self.registerUser(self.phoneNumber, password:self.password.text)
        }else{
           TTAlertNoTitle("两次密码不一致")
        }
    }
    
    func registerUser(phoneNum: NSString!, password: NSString!)
    {
        print("\(phoneNum) password \(password)")
        Alamofire.request(.POST, RegisterUrl, parameters: ["mobile": phoneNum!,"password": password])
            .responseJSON { response in
                var json = JSON(response.result.value!)
                print(json)
                let code = json["code"].stringValue
                print(code)
                if code == "success"{
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        }
    }
}
