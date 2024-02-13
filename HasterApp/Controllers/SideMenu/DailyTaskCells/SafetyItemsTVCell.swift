//
//  SafetyItemsTVCell.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit
import DLRadioButton

class SafetyItemsTVCell: UITableViewCell {
    
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var yesSelectionbtn: DLRadioButton!
    @IBOutlet weak var noSelectionbtn: DLRadioButton!
    @IBOutlet weak var NASelectionbtn: DLRadioButton!

    var btnCallBack: ((Int)-> Void)?
    
    @IBAction func yesSectionButton(_ sender: Any) {
        self.btnCallBack?(1)
        self.yesSelectionbtn.isSelected = true
        self.noSelectionbtn.isSelected = false
        self.NASelectionbtn.isSelected = false
    }
    
    @IBAction func noSectionButton(_ sender: Any) {
        self.btnCallBack?(0)
        self.yesSelectionbtn.isSelected = false
        self.noSelectionbtn.isSelected = true
        self.NASelectionbtn.isSelected = false
    }
    
    @IBAction func NASectionButton(_ sender: Any) {
        self.btnCallBack?(2)
        self.yesSelectionbtn.isSelected = false
        self.noSelectionbtn.isSelected = false
        self.NASelectionbtn.isSelected = true
    }
    
    func setState(value: Int?) {
        if (value == 0) {
            self.noSelectionbtn.isSelected = true
            self.yesSelectionbtn.isSelected = false
            self.NASelectionbtn.isSelected = false
        }
        else if (value == 1) {
            self.noSelectionbtn.isSelected = false
            self.yesSelectionbtn.isSelected = true
            self.NASelectionbtn.isSelected = false
        }
        else if (value == 2) {
            self.noSelectionbtn.isSelected = false
            self.yesSelectionbtn.isSelected = false
            self.NASelectionbtn.isSelected = true
        }
        else {
            self.noSelectionbtn.isSelected = false
            self.yesSelectionbtn.isSelected = false
            self.NASelectionbtn.isSelected = false
        }
    }
}
