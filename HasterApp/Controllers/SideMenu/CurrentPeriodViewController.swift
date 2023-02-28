//
//  CurrentPeriodViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 30/06/2021.
//

import UIKit
import DLRadioButton
import ActionSheetPicker_3_0
class CurrentPeriodViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var isEdit = true
    var userID = ""
    var jobs : [Records] = []
    var records : [Records] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if let colorAsData = UserDefaults.standard.object(forKey: "userid") as? String{userID = colorAsData;self.getJobs()}
        else{}
    }
    @IBAction func editButton(_ sender: Any) {
        if isEdit == false
        {
            NetworkManager.jobBulkUpdate(id: userID, records: self.records) { data, status in
                self.showAlert(title: "Success", message: "Bulk records updated successfully")
                self.getJobs()
            }
        }
         isEdit = !isEdit
        self.tableView.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getJobs(){
        self.startAnimating()
        NetworkManager.currentPeriod(eid: userID) { data, status in
            self.stopsAnimating()
            if let job = data?.records {
                self.jobs = job
                self.records = job
                self.tableView.reloadData()
            }
        }
    }
    @objc func editJob(sender:UIButton){
        let detail = ProfileShareVC.init()
        detail.delegate = self
        detail.userID = userID
        detail.record = jobs[sender.tag]
        detail.modalPresentationStyle = .overFullScreen
        self.present(detail, animated: true)
    }
    
    
    @objc func oTPressed(_ sender: DLRadioButton) {
        self.records[sender.tag].ot_hours = "1"
        self.records[sender.tag].reg_hours = "0"
        self.tableView.reloadData()
    }
    
    @objc func regPressed(_ sender: DLRadioButton) {
        self.records[sender.tag].ot_hours = "1"
        self.records[sender.tag].reg_hours = "0"
        self.tableView.reloadData()
    }
    
    @objc func dc1Action(_ sender: DLRadioButton) {
        self.records[sender.tag].dc = "14"
        self.tableView.reloadData()
    }
    
    @objc func dc2Action(_ sender: DLRadioButton) {
        self.records[sender.tag].dc = "30"
        self.tableView.reloadData()
    }
    @objc func injAction(_ sender: DLRadioButton) {
        if self.records[sender.tag].injury_free_day == "1"{
            self.records[sender.tag].injury_free_day = "0"
        }
        else{
            self.records[sender.tag].injury_free_day = "1"
        }
        self.tableView.reloadData()
    }
    
    @objc func lockAction(_ sender: DLRadioButton) {
        if self.records[sender.tag].emp_locked == "1"{
            self.records[sender.tag].emp_locked = "0"
        }
        else{
            self.records[sender.tag].emp_locked = "1"
        }
        self.tableView.reloadData()
    }
    
    @objc func startTimeAction(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: { picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            self.records[sender.tag].start_time = dateFormatter.string(from: (value as! Date))
            
        }, cancel: { picker in
            
        }, origin: sender)
    }
    @objc func timeAction(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: { picker, value, index in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            self.records[sender.tag].end_time = dateFormatter.string(from: (value as! Date))
            
        }, cancel: { picker in
            
        }, origin: sender)
    }
    
}

extension CurrentPeriodViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEdit{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentTableViewCell") as! CurrentTableViewCell
        let obj = jobs[indexPath.row]
        cell.titleLbl.text = obj.job_title
        cell.addressLbl.text = obj.job_address
        cell.stlbl.text = obj.start_time
        cell.etlbl.text = obj.end_time
        cell.dclbl.text = obj.dc
        cell.hourslbl.text = "0 hours"
        cell.jobnumLbl.text = obj.job_no
        if obj.ot_hours == "1"{
            cell.oTimage.image = UIImage(named: "tk")
        }
        else{
            cell.oTimage.image = UIImage(named: "cs")
        }
        if obj.reg_hours == "1"{
            cell.rgImage.image = UIImage(named: "tk")
        }
        else{
            cell.rgImage.image = UIImage(named: "cs")
        }
        if obj.injury_free_day == "1"{
            cell.injImage.image = UIImage(named: "tk")
        }
        else{
            cell.injImage.image = UIImage(named: "cs")
        }
        if obj.emp_locked == "1"{
            cell.editButton.setImage(UIImage(named: "lk"), for: .normal)
            
        }
        else{
            cell.editButton.tag = indexPath.row
            cell.editButton.setImage(UIImage(named: "pe"), for: .normal)
            cell.editButton.addTarget(self, action: #selector(editJob(sender:)), for: .touchUpInside)
        }
            return cell}
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editCell") as! CurrentTableViewCell
            let obj = records[indexPath.row]
            cell.jobnumLbl.text = obj.job_no ?? ""
            cell.startBtn.setTitle(obj.start_time ?? "", for: .normal)
            cell.endBtn.setTitle(obj.end_time ?? "", for: .normal)
            if obj.ot_hours == "1"{
                cell.overTimeHoursbtn.isSelected = true
                cell.rgHoursBtn.isSelected = false
            }
            else{
                cell.overTimeHoursbtn.isSelected = false
                cell.rgHoursBtn.isSelected = true
            }
            if obj.dc == "14"{
                cell.dc1Btn.isSelected = true
                cell.dc2Btn.isSelected = false
            }
            else{
                cell.dc1Btn.isSelected = false
                cell.dc2Btn.isSelected = true
            }
            if obj.injury_free_day == "1"{
                cell.injFreeBtn.setImage(UIImage(named: "ck"), for: .normal)
            }
            else{
                cell.injFreeBtn.setImage(UIImage(named: "uck"), for: .normal)
            }
            if obj.emp_locked == "1"{
                cell.lockBtn.setImage(UIImage(named: "ck"), for: .normal)
            }
            else{
                cell.lockBtn.setImage(UIImage(named: "uck"), for: .normal)
            }
            cell.dc1Btn.tag = indexPath.row
            cell.dc2Btn.tag = indexPath.row
            cell.endBtn.tag = indexPath.row
            cell.startBtn.tag = indexPath.row
            cell.injFreeBtn.tag = indexPath.row
            cell.lockBtn.tag = indexPath.row
            cell.endBtn.addTarget(self, action: #selector(timeAction(_:)), for: .touchUpInside)
            cell.startBtn.addTarget(self, action: #selector(startTimeAction(_:)), for: .touchUpInside)
            cell.overTimeHoursbtn.addTarget(self, action: #selector(oTPressed(_:)), for: .touchUpInside)
            cell.rgHoursBtn.addTarget(self, action: #selector(regPressed(_:)), for: .touchUpInside)
            cell.dc1Btn.addTarget(self, action: #selector(dc1Action(_:)), for: .touchUpInside)
            cell.dc2Btn.addTarget(self, action: #selector(dc2Action(_:)), for: .touchUpInside)
            cell.injFreeBtn.addTarget(self, action: #selector(injAction(_:)), for: .touchUpInside)
            cell.lockBtn.addTarget(self, action: #selector(lockAction(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
}

extension CurrentPeriodViewController: ProfileShareVCDelegate{
    func passData() {
        getJobs()
    }
    
    
}
