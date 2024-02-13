//
//  ManualListTVCell.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit

class ManualListTVCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var entryTextField: UITextField!
    
    var entryCallBack: ((String)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        entryTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField == entryTextField) {
            self.entryCallBack?(entryTextField.text ?? "")
        }
    }
}
