//
//  DailyTasksHeaderView.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 27/08/2023.
//

import UIKit

class DailyTasksHeaderView: UIView {
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBOutlet weak var yesNoView: UIView!
    @IBOutlet weak var incidentsView: UIView!
    @IBOutlet weak var addSubtractView: UIView!
    
    var addCallBack: (() -> Void)?
    var subtractCallBack: (() -> Void)?
    
    func showAddSubtractView() {
        yesNoView.isHidden = true
        addSubtractView.isHidden = false
        incidentsView.isHidden = true
    }
    
    func showYesNoView() {
        yesNoView.isHidden = false
        addSubtractView.isHidden = true
        incidentsView.isHidden = true
    }
    
    func showIncidentsView() {
        yesNoView.isHidden = true
        addSubtractView.isHidden = true
        incidentsView.isHidden = false
    }
    
    @IBAction func addButton(_ sender: Any) {
        self.addCallBack?()
    }
    
    @IBAction func subtractButton(_ sender: Any) {
        self.subtractCallBack?()
    }
}
