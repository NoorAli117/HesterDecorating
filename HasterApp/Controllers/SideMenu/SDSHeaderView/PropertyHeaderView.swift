//
//  PropertyHeader.swift
//  Customer App
//
//  Created by mac on 14/03/2020.
//  Copyright © 2020 Shahbaz Khan. All rights reserved.
//

import UIKit

class PropertyHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dropDownImage: UIButton!
    @IBOutlet weak var ExpendButton: UIButton!
    
     override func awakeFromNib() {
           super.awakeFromNib()
           self.setupUI()
       }
       
       func setupUI() {
       //self.titleLabel.font = Font.boldFont(17)
    
       }
}
