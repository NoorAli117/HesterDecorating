//
//  DailyTaskTopTVCell.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit

class DailyTaskTopTVCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var leadPainterTextField: UITextField!
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var jobNoTextField: UITextField!
    @IBOutlet weak var taskToBeCompletedTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    
    var leadPaintCallBack: ((String)-> Void)?
    var projectNameCallBack: ((String)-> Void)?
    var jobNoCallBack: ((String)-> Void)?
    var taskCompletedCallBack: ((String)-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateButton.layer.borderWidth = 1
        dateButton.layer.cornerRadius = 5
        dateButton.layer.borderColor = UIColor.systemGray5.cgColor
        
        leadPainterTextField.delegate = self
        projectNameTextField.delegate = self
        jobNoTextField.delegate = self
        taskToBeCompletedTextField.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField == leadPainterTextField) {
            self.leadPaintCallBack?(leadPainterTextField.text ?? "")
        }
        else if (textField == projectNameTextField) {
            self.projectNameCallBack?(projectNameTextField.text ?? "")
        }
        else if (textField == jobNoTextField) {
            self.jobNoCallBack?(jobNoTextField.text ?? "")
        }
        else if (textField == taskToBeCompletedTextField) {
            self.taskCompletedCallBack?(taskToBeCompletedTextField.text ?? "")
        }
    }
}
