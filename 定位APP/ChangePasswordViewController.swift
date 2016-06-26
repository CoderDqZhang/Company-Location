//
//  ChangePasswordViewController.swift
//  定位APP
//
//  Created by Jane on 11/19/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BasePassWordViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置密码"
        super.nextStep.setTitle("完成", forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func nextStep(sender: UIButton) {
        if super.isSuccess(){
            
        }else{
            TTAlertNoTitle("两次密码不一致")
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
