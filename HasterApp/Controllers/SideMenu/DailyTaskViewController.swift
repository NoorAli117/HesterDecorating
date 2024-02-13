//
//  DailyTaskViewController.swift
//  HasterApp
//
//  Created by Aakif Nadeem on 26/08/2023.
//

import UIKit

class DailyTaskViewController: BaseViewController {
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = DailyTaskModel()
    var datePicker : UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerCell(type: DailyTaskTopTVCell.self)
        self.tableView.registerCell(type: SafetyItemsTVCell.self)
        self.tableView.registerCell(type: ManualListTVCell.self)
        self.tableView.registerCell(type: IncidentsTVCell.self)
        self.tableView.registerCell(type: SubmitTVCell.self)
    }
    
    //Date
    @objc func selectDate(_ sender: UIButton)
    {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        let dateChooserAlert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { action in
            self.donedatePicker(sender: self.datePicker)
        }))
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view ?? UIView(), attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        
        // Set the popover presentation properties
        if let popoverPresentationController = dateChooserAlert.popoverPresentationController {
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
            popoverPresentationController.permittedArrowDirections = .any
        }
        
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
    
    func donedatePicker(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DailyTaskTopTVCell
        let dateString = formatter.string(from: sender.date)
        cell.dateButton.setTitle(dateString, for: .normal)
        cell.dateButton.tintColor = .black
        self.model.date = dateString
    }
    
    func callAPI() {
        if self.checkValidate() {
            self.startAnimating()
            NetworkManager.submitDailyTask(model: model) { msg, status in
                self.stopsAnimating()
                if status {
                    self.showAlert(title: "Succeeded", message: "The daily task has been submitted successfully")
                    self.model = DailyTaskModel()
                    self.tableView.reloadData()
                }
                else {
                    self.showAlert(title: "Error", message: msg ?? "")
                }
            }
        }
    }
    
    func checkValidate() -> Bool {
        var error = ""
        
        if model.leadPainter.isEmpty {
            error = "Lead painter field is required!"
        }
        else if model.date.isEmpty {
            error = "Date field is required!"
        }
        else if model.projectName.isEmpty {
            error = "Project name field is required!"
        }
        else if model.jobNumber.isEmpty {
            error = "Job no. field is required!"
        }
        else if model.taskCompleted.isEmpty {
            error = "Task to be completed field is required!"
        }
        else {
            for x in 0..<model.safetyItemObj.count {
                for y in 0..<model.safetyItemObj[x].options.count {
                    if (model.safetyItemObj[x].options[y].selection == nil) {
                        error = "\(model.safetyItemObj[x].options[y].description) field is required!"
                        break
                    }
                }
                if !error.isEmpty { break }
            }
            
            if error.isEmpty {
                for x in 0..<model.incidentObj.count {
                    if (model.incidentObj[x].selection == nil) {
                        error = "All incidents fields are required!"
                        break
                    }
                }
            }
            
            if error.isEmpty {
                if model.workTaskPerformaceList.list.first?.isEmpty ?? false {
                    error = "Work task performed field are required!"
                }
            }
            
            if error.isEmpty {
                if model.potentialHazardList.list.first?.isEmpty ?? false {
                    error = "Potential hazards field are required!"
                }
            }
            
            if error.isEmpty {
                if model.employeeSignatureList.list.first?.isEmpty ?? false {
                    error = "Employee signature are required!"
                }
            }
        }
        
        if !error.isEmpty {
            self.showAlert(title: "Alert", message: error)
            return false
        }
        else {
            return true
        }
    }
}

//MARK: Table View
extension DailyTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.safetyItemObj.count + 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || (section == self.model.safetyItemObj.count +  5){
            return 1
        }
        else if (section == self.model.safetyItemObj.count + 1) {
            return model.incidentObj.count
        }
        else if (section == self.model.safetyItemObj.count + 2) {
            return model.workTaskPerformaceList.list.count
        }
        else if (section == self.model.safetyItemObj.count +  3) {
            return model.potentialHazardList.list.count
        }
        else if (section == self.model.safetyItemObj.count +  4) {
            return model.employeeSignatureList.list.count
        }
        else {
            return model.safetyItemObj[section - 1].options.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("DailyTasksHeaderView", owner: self, options: nil)?.first as? DailyTasksHeaderView
        
        if (section != 0 && section < self.model.safetyItemObj.count + 1) {
            headerView?.headerTitleLabel.text = self.model.safetyItemObj[section - 1].title
            headerView?.showYesNoView()
            return headerView
        }
        else if (section == self.model.safetyItemObj.count + 1) {
            headerView?.showIncidentsView()
            headerView?.headerTitleLabel.text = "INCIDENTS"
            headerView?.headerTitleLabel.numberOfLines = 1
            return headerView
        }
        else if (section == self.model.safetyItemObj.count + 2) {
            headerView?.headerTitleLabel.text = self.model.workTaskPerformaceList.title
            headerView?.showAddSubtractView()
            headerView?.addCallBack = {
                self.model.workTaskPerformaceList.list.append("")
                self.tableView.reloadData()
            }
            headerView?.subtractCallBack = {
                if (self.model.workTaskPerformaceList.list.count > 1) {
                    self.model.workTaskPerformaceList.list.removeLast()
                    self.tableView.reloadData()
                }
            }
            return headerView
        }
        else if (section == self.model.safetyItemObj.count +  3) {
            headerView?.headerTitleLabel.text = self.model.potentialHazardList.title
            headerView?.showAddSubtractView()
            headerView?.addCallBack = {
                self.model.potentialHazardList.list.append("")
                self.tableView.reloadData()
            }
            headerView?.subtractCallBack = {
                if (self.model.potentialHazardList.list.count > 1) {
                    self.model.potentialHazardList.list.removeLast()
                    self.tableView.reloadData()
                }
            }
            return headerView
        }
        else if (section == self.model.safetyItemObj.count +  4) {
            headerView?.headerTitleLabel.text = self.model.employeeSignatureList.title
            headerView?.showAddSubtractView()
            headerView?.addCallBack = {
                self.model.employeeSignatureList.list.append("")
                self.tableView.reloadData()
            }
            headerView?.subtractCallBack = {
                if (self.model.employeeSignatureList.list.count > 1) {
                    self.model.employeeSignatureList.list.removeLast()
                    self.tableView.reloadData()
                }
            }
            return headerView
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TopView
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTaskTopTVCell") as! DailyTaskTopTVCell
            cell.dateButton.addTarget(self, action: #selector(self.selectDate(_:)), for: .touchUpInside)
            cell.leadPainterTextField.text = self.model.leadPainter
            cell.projectNameTextField.text = self.model.projectName
            cell.jobNoTextField.text = self.model.jobNumber
            cell.taskToBeCompletedTextField.text = self.model.taskCompleted
            cell.dateButton.setTitle(self.model.date.isEmpty ? "Date" : self.model.date, for: .normal)
            
            cell.leadPaintCallBack = { value in
                self.model.leadPainter = value
            }
            cell.projectNameCallBack = { value in
                self.model.projectName = value
            }
            cell.jobNoCallBack = { value in
                self.model.jobNumber = value
            }
            cell.taskCompletedCallBack = { value in
                self.model.taskCompleted = value
            }
            return cell
        }
        
        //Incidents
        else if indexPath.section == self.model.safetyItemObj.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IncidentsTVCell") as! IncidentsTVCell
            cell.mainTextLabel.text = self.model.incidentObj[indexPath.row].description
            cell.setState(value: self.model.incidentObj[indexPath.row].selection)
            if (indexPath.row == 2) {
                cell.noSelectionLabel.text = "N/A"
            }
            else {
                cell.noSelectionLabel.text = "No"
            }
            
            cell.btnCallBack = { value in
                self.model.incidentObj[indexPath.row].selection = value
            }
            return cell
        }
        
        //Work Task
        if (indexPath.section == self.model.safetyItemObj.count +  2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManualListTVCell") as! ManualListTVCell
            cell.entryTextField.placeholder = "Enter Work Task \(indexPath.row + 1)"
            cell.entryTextField.text = self.model.workTaskPerformaceList.list[indexPath.row]
            cell.entryCallBack = { value in
                self.model.workTaskPerformaceList.list[indexPath.row] = value
            }
            return cell
        }
        //Potential Hazards
        else if (indexPath.section == self.model.safetyItemObj.count +  3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManualListTVCell") as! ManualListTVCell
            cell.entryTextField.placeholder = "Enter Potential Hazard \(indexPath.row + 1)"
            cell.entryTextField.text = self.model.potentialHazardList.list[indexPath.row]
            cell.entryCallBack = { value in
                self.model.potentialHazardList.list[indexPath.row] = value
            }
            return cell
        }
        //Signatures
        else if (indexPath.section == self.model.safetyItemObj.count +  4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManualListTVCell") as! ManualListTVCell
            cell.entryTextField.placeholder = "Enter Employee Signature \(indexPath.row + 1)"
            cell.entryTextField.text = self.model.employeeSignatureList.list[indexPath.row]
            cell.entryCallBack = { value in
                self.model.employeeSignatureList.list[indexPath.row] = value
            }
            return cell
        }
        
        //Submit
        else if (indexPath.section == self.model.safetyItemObj.count +  5) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitTVCell") as! SubmitTVCell
            cell.btnCallBack = {
                self.callAPI()
            }
            return cell
        }
        
        //Safety Items
        else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SafetyItemsTVCell") as! SafetyItemsTVCell
            let objAtIndex = self.model.safetyItemObj[indexPath.section - 1].options[indexPath.row]
            
            cell.mainTextLabel.text = objAtIndex.description
            cell.setState(value: objAtIndex.selection)
            
            cell.btnCallBack = { value in
                self.model.safetyItemObj[indexPath.section - 1].options[indexPath.row].selection = value
            }
            return cell
        }
    }
}

