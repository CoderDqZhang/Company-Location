//
//  GetJson.swift
//  定位APP
//
//  Created by Jane on 11/22/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetJson: NSObject {
    func getUserInfo(data:JSON) -> UserInfos{
        print(data)
        var user:UserInfos!
        user.code = data["code"].stringValue
        user.inf?.intro = data["inf"]["intro"].stringValue
        user.inf?.headImg = data["inf"]["headImg"].stringValue
        user.inf?.name = data["inf"]["name"].stringValue
        return user
    }
}
