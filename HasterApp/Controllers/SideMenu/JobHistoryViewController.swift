//
//  JobHistoryViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 30/06/2021.
//

import UIKit

class JobHistoryViewController: BaseViewController {

    var userID = ""
    var jobs : [Records] = []
    var records : [Records] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let colorAsData = UserDefaults.standard.object(forKey: "userid") as? String{userID = colorAsData;self.getJobs()}
        else{}
    }

    @IBAction func backPressed(_ sender: Any) {
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
}

extension JobHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentTableViewCell") as! CurrentTableViewCell
        let obj = jobs[indexPath.row]
        cell.titleLbl.text = obj.job_title
        cell.addressLbl.text = obj.job_address
        cell.stlbl.text = obj.start_time
        cell.etlbl.text = obj.end_time
        cell.dclbl.text = obj.dc
        cell.hourslbl.text = "0 hours"
        cell.jobLbl.text = obj.job_no
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 290
    }
    
}
