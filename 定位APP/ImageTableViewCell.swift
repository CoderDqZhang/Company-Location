//
//  ImageTableViewCell.swift
//  定位APP
//
//  Created by Jane on 11/22/15.
//  Copyright © 2015 Jane. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    var photoView:UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.photoView = UIImageView(frame: CGRectMake(10, 10, UISCREEN_WIDTH-20, UISCREEN_WIDTH-20))
        self.contentView.addSubview(self.photoView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
