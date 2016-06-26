//
//  ForgetPassViewController.swift
//  定位APP
//
//  Created by Jane on 11/19/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class ForgetPassViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "忘记密码"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func nextStep(sender: UIButton) {
        SMSSDK.commitVerificationCode(self.verificationCode.text, phoneNumber: self.userName.text, zone: "86", result: { error in
            
            if (error==nil){
                self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
            }else{
                TTAlertNoTitle("验证失败")
            }
            
        })
        
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
