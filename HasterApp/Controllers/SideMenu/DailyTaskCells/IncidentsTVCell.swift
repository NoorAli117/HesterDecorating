//
//  IncidentsTVCell.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit
import DLRadioButton

class IncidentsTVCell: UITableViewCell {
    
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var yesSelectionbtn: DLRadioButton!
    @IBOutlet weak var noSelectionbtn: DLRadioButton!
    @IBOutlet weak var noSelectionLabel: UILabel!
    

    var btnCallBack: ((Int)-> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setState(value: Int?) {
        if (value == 0) {
            self.noSelectionbtn.isSelected = true
            self.yesSelectionbtn.isSelected = false
        }
        else if (value == 1) {
            self.noSelectionbtn.isSelected = false
            self.yesSelectionbtn.isSelected = true
        }
        else {
            self.noSelectionbtn.isSelected = false
            self.yesSelectionbtn.isSelected = false
        }
    }

    
    @IBAction func yesSectionButton(_ sender: Any) {
        self.btnCallBack?(1)
        self.yesSelectionbtn.isSelected = true
        self.noSelectionbtn.isSelected = false
    }
    
    @IBAction func noSectionButton(_ sender: Any) {
        self.btnCallBack?(0)
        self.yesSelectionbtn.isSelected = false
        self.noSelectionbtn.isSelected = true
    }
}
