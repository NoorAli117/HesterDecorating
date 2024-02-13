//
//  HomeViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 28/06/2021.
//

import UIKit
import ModernSearchBar
import DLRadioButton
import ActionSheetPicker_3_0
import DropDown
class HomeViewController: BaseViewController {
    
    @IBOutlet weak var selectTimeButton: UIButton!
    @IBOutlet weak var nowBtn: UIButton!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var timePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var overTimeHoursbtn: DLRadioButton!
    @IBOutlet weak var rgHoursBtn: DLRadioButton!
    @IBOutlet weak var modernSearchBar: ModernSearchBar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dc1Btn: DLRadioButton!
    @IBOutlet weak var dc2Btn: DLRadioButton!
    @IBOutlet weak var yesBtn: DLRadioButton!
    @IBOutlet weak var noBtn: DLRadioButton!
    let userDefaults = UserDefaults.standard
    var rgHours : Int = 1
    var otHours : Int = 0
    var userID = ""
    var selectedJobs : JobsData!
    let dropDown = DropDown()
    var timer = Timer()
    var isStarted : Bool = true
    var jobs : [JobsData] = []
    var startTime = ""
    var startDate = Date()
    var endDate: Date!
    var endTime = ""
    var isCovid = true
    var dc = 14
    var isAlreadyStart = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if let decoded = userDefaults.object(forKey: "JobName") as? String, let num = userDefaults.object(forKey: "JobNum") as? String {
            selectedJobs = JobsData()
            selectedJobs.job_name = decoded
            selectedJobs.job_number = num
            self.isAlreadyStart = true
            self.modernSearchBar.text = selectedJobs.job_number ?? ""
            self.jobLabel.text = "you are working on job: \(decoded)"
        }
        self.getJobs()
        if let colorAsData = UserDefaults.standard.object(forKey: "userid") as? String{userID = colorAsData}
        modernSearchBar.setImage(UIImage(), for: .search, state: .normal)
        self.customDesign()
        self.selectTimeButton.isHidden = true
        self.timePickerHeight.constant = 0
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
    }
    
    @objc func tick() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .full, timeStyle: .none)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
    
    @IBAction func SDSDocumentAction(_ sender: Any) {
        let loginVC = SDSViewController.instantiate(storyboardName: "Main")
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func DailyHazardAction(_ sender: Any) {
        let loginVC = DailyTaskViewController.instantiate(storyboardName: "Main")
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func menuAction(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    @IBAction func oTPressed(_ sender: Any) {
        overTimeHoursbtn.isSelected = true
        rgHoursBtn.isSelected = false
        rgHours = 0
        otHours = 1
    }
    
    @IBAction func regPressed(_ sender: Any) {
        overTimeHoursbtn.isSelected = false
        rgHoursBtn.isSelected = true
        rgHours = 1
        otHours = 0
    }
    
    
    @IBAction func dc1Action(_ sender: DLRadioButton) {
        dc1Btn.isSelected = true
        dc2Btn.isSelected = false
        dc = 14
    }
    
    @IBAction func dc2Action(_ sender: DLRadioButton) {
        dc1Btn.isSelected = false
        dc2Btn.isSelected = true
        dc = 30
    }
    
    @IBAction func yesAction(_ sender: Any) {
        yesBtn.isSelected = true
        noBtn.isSelected = false
        isCovid = true
    }
    @IBAction func noAction(_ sender: Any) {
        yesBtn.isSelected = false
        isCovid = true
        noBtn.isSelected = true
    }
    @IBAction func nowPressed(_ sender: Any) {
        dropDown.dataSource = ["Now","Custom"]
        dropDown.anchorView = startView
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0{
                self.timePickerHeight.constant = 0
                self.selectTimeButton.isHidden =  true
                self.nowBtn.setTitle("Now", for: .normal)
            }
            else{
                self.timePickerHeight.constant = 42
                self.selectTimeButton.isHidden = false
                self.nowBtn.setTitle("Custom", for: .normal)
            }
        }
    }
    
    @IBAction func inqPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    private func configureSearchBar(){
        
        var suggestionList = Array<String>()
        for a in self.jobs{
            let str = (a.job_name ?? "") + " | " + (a.job_number ?? "") + " | " + (a.job_address ?? "")
            suggestionList.append(str)
        }
        self.modernSearchBar.delegateModernSearchBar = self
        self.modernSearchBar.setDatas(datas: suggestionList)
    }
    
    @IBAction func timeAction(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: { picker, value, index in
            _ = DateFormatter.localizedString(from: (value as! Date), dateStyle: .none, timeStyle: .short)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            sender.setTitle(dateFormatter.string(from: (value as! Date)), for: .normal)
            if self.isStarted{
                self.startTime = dateFormatter.string(from: (value as! Date))
                print(self.startTime)
                self.startDate = (value as? Date)!
            } else {
                self.endTime = dateFormatter.string(from: (value as! Date))
                print(self.endTime)
                self.endDate = (value as? Date)!
            }
        }, cancel: { picker in
            
        }, origin: sender)
    }
    
    @IBAction func startPressed(_ sender: Any) {
        buttonView.isHidden = true
        mainView.isHidden = false
        startView.isHidden = false
        endView.isHidden = true
        isStarted = true
        bottomBtn.isHidden = false
        bottomBtn.setTitle("End Time", for: .normal)
        
    }
    @IBAction func endPressed(_ sender: Any) {
        buttonView.isHidden = true
        mainView.isHidden = false
        startView.isHidden = true
        endView.isHidden = false
        isStarted = false
        bottomBtn.isHidden = false
        bottomBtn.setTitle("Start Time", for: .normal)
    }
    @IBAction func bottomAction(_ sender: Any) {
        if isStarted{
            buttonView.isHidden = true
            mainView.isHidden = false
            startView.isHidden = true
            endView.isHidden = false
            bottomBtn.setTitle("Start Time", for: .normal)
            
        }
        else{
            buttonView.isHidden = true
            mainView.isHidden = false
            startView.isHidden = false
            endView.isHidden = true
            bottomBtn.setTitle("End Time", for: .normal)
        }
        isStarted = !isStarted
    }
    @IBAction func submitAction(_ sender: Any) {
        let ip = getIPAddress()
        if selectedJobs == nil{
            showAlert(title: "", message: "Please Select a job")
            return
        }
        if isStarted{
            if isAlreadyStart{
                showAlert(title: "", message: "Please Finish first job")
                return
            }
            self.startAnimating()
            NetworkManager.jobStart(uid: userID, job_number: selectedJobs.job_number!, dc: dc, start_time: startTime, reg_hours: rgHours,otHours: otHours, covid: isCovid, ip: ip) { [self] data, status in
                if status{
                    userDefaults.set(selectedJobs.job_name, forKey: "JobName")
                    userDefaults.set(selectedJobs.job_number, forKey: "JobNum")
                    self.userDefaults.synchronize()
                    self.mainView.isHidden = true
                    self.bottomBtn.isHidden = true
                    self.buttonView.isHidden = false
                    self.showAlert(title: "Success", message: data ?? "")
                }
                self.stopsAnimating()
            }
        }
        else {
            if endTime == "" {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                self.endTime = dateFormatter.string(from: (Date()))
                endDate = Date()
            }
            if endDate < startDate {
                showAlert(title: "error", message: "End time should be greater than start time.")
            }
            NetworkManager.jobEnd(uid: userID, job_number: selectedJobs.job_number!, end_time: endTime, injury_free_day: 1, ip: ip) { data, status in
                if status{
                    self.isAlreadyStart = false
                    self.mainView.isHidden = true
                    self.bottomBtn.isHidden = true
                    self.buttonView.isHidden = false
                    self.userDefaults.set(nil, forKey: "JobName")
                    self.userDefaults.set(nil, forKey: "JobNum")
                    self.showAlert(title: "Success", message: data ?? "")
                }
            }
        }
    }
    
    func getJobs(){
        self.startAnimating()
        NetworkManager.getJobs { data in
            self.stopsAnimating()
            if let jobs = data{
                self.jobs = jobs.data ?? []
                self.configureSearchBar()
            }
            else{
                self.showAlert(title: "", message: "Something went wrong!")
            }
        }
    }
}

extension HomeViewController:ModernSearchBarDelegate{
    func onClickItemSuggestionsView(item: String) {
        print("User touched this item: "+item)
        modernSearchBar.text = item
        for a in jobs{
            if item.contains(a.job_number ?? ""){
                selectedJobs = a
                jobLabel.text = "you are working on job: \(a.job_name ?? "")"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                self.startTime = dateFormatter.string(from: (Date()))
                break
            }
        }
//        modernSearchBar.closeSuggestionsView() TO DO
    }
    
    ///Called if you use Custom Item suggestion list
    func onClickItemWithUrlSuggestionsView(item: ModernSearchBarModel) {
        print("User touched this item: "+item.title+" with this url: "+item.url.description)
    }
    
    ///Called when user touched shadowView
    func onClickShadowView(shadowView: UIView) {
        print("User touched shadowView")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text did change, what i'm suppose to do ?")
    }
    
    private func customDesign(){
        
        self.modernSearchBar.shadowView_alpha = 1
        
        //Modify the default icon of suggestionsView's rows
        self.modernSearchBar.searchImage = UIImage()//ModernSearchBarIcon.Icon.none.image
        
        //Modify properties of the searchLabel
        // self.modernSearchBar.searchLabel_font = UIFont(name: "Avenir-Light", size: 30)
        self.modernSearchBar.searchLabel_textColor = UIColor.black
        self.modernSearchBar.searchLabel_backgroundColor = UIColor.white
        
        //Modify properties of the searchIcon
        self.modernSearchBar.suggestionsView_searchIcon_height = 0
        self.modernSearchBar.suggestionsView_searchIcon_width = 0
        self.modernSearchBar.suggestionsView_searchIcon_isRound = false
        self.modernSearchBar.suggestionsView_maxHeight = 1000
        ///Modify properties of the suggestionsView
        self.modernSearchBar.suggestionsView_backgroundColor = UIColor.white
        self.modernSearchBar.suggestionsView_contentViewColor = UIColor.white
        self.modernSearchBar.suggestionsView_separatorStyle = .singleLine
        self.modernSearchBar.suggestionsView_selectionStyle = UITableViewCell.SelectionStyle.gray
        self.modernSearchBar.suggestionsView_verticalSpaceWithSearchBar = 5
        self.modernSearchBar.suggestionsView_spaceWithKeyboard = 5
    }
    
    func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
}
