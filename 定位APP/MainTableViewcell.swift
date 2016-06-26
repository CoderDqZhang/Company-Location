//
//  MainTableViewcell.swift
//  定位APP
//
//  Created by Jane on 11/24/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class MainTableViewcell: UITableViewCell {

    var photoView:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.photoView = UIImageView(frame: CGRectMake(10, 10, UISCREEN_WIDTH-20, UISCREEN_WIDTH-20))
        self.contentView.addSubview(self.photoView)
    }
    
    func setData(imageUrl:NSString){
        if imageUrl != ""{
            self.photoView .sd_setImageWithURL(NSURL(string:"\(ImageUrl)\(imageUrl)"), placeholderImage: UIImage(named: "home_leftBt"))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
