//
//  SubmitTVCell.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit

class SubmitTVCell: UITableViewCell {

    var btnCallBack: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func submitSectionButton(_ sender: Any) {
        self.btnCallBack?()
    }
}
