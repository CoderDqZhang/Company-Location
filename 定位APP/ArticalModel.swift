//
//  articalModel.swift
//  定位APP
//
//  Created by Jane on 11/24/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit
import SwiftyJSON

class Photo: NSObject {
    var path:NSString!
    var width:NSString!
    var height:NSString!
}

class ZipPhoto:NSObject {
    var path:NSString!
    var width:NSString!
    var height:NSString!
}

class ArticalModel: NSObject {
    var date:NSString!
    var photo:Photo!
    var zipPhoto:ZipPhoto!
    var pos:NSString!
    
}




//func getArticleList(data:JSON)-> NSMutableArray{
//    
//}