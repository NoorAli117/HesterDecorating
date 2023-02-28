//
//  ProfileShareVC.swift
//  ExtraMiles
//
//  Created by Usama Ali on 06/02/2021.
//

import UIKit
import DLRadioButton
import ActionSheetPicker_3_0
protocol ProfileShareVCDelegate : AnyObject {
    func passData()
}
class ProfileShareVC: BaseViewController {

   
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var overTimeHoursbtn: DLRadioButton!
    @IBOutlet weak var rgHoursBtn: DLRadioButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var dc1Btn: DLRadioButton!
    @IBOutlet weak var dc2Btn: DLRadioButton!
    
    @IBOutlet var holderView : UIView!
    var record : Records?
    var userID = ""
    var rgHours : String = "1"
    var otHours : String = "0"
    var isStarted : Bool = true
    var startTime = ""
    var endTime = ""
    var isCovid = true
    var dc = "14"
    var injFree = "0"
    var lock = "0"
    
    weak var delegate : ProfileShareVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jobLabel.text = record?.job_no
        self.startBtn.setTitle(record?.start_time ?? "", for: .normal)
        self.endBtn.setTitle(record?.end_time ?? "", for: .normal)
        self.startTime = record?.start_time ?? ""
        self.endTime = record?.end_time ?? ""
        
        if record?.dc == "30"{
            dc = "30"
            self.dc1Btn.isSelected = false
            self.dc2Btn.isSelected = true
        }
        if record?.reg_hours == "0"{
            self.rgHoursBtn.isSelected = false
            self.overTimeHoursbtn.isSelected = true
            self.otHours = "1"
            self.rgHours = "0"
        }
        
    }
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var resetPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    init( ) {
        super.init(nibName: "ProfileShareVC", bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fadeBackgroundAnimation(false,completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.initialTouchPoint = self.holderView.frame.origin
        self.resetPoint = self.holderView.frame.origin
    }
    
    private func fadeBackgroundAnimation(_ isHidden : Bool, completion : (()->())?){
        UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseIn, animations: {
            //self.view.backgroundColor = UIColor.black//colorRGB(0, withGreen: 0, withBlue: 0, andAlpha: isHidden ? 0.0 :  0.7)
        }, completion: {(finished: Bool) -> Void in
            completion?()
        })
    }
    
    @IBAction func oTPressed(_ sender: Any) {
        overTimeHoursbtn.isSelected = true
        rgHoursBtn.isSelected = false
        rgHours = "0"
        otHours = "1"
        record?.reg_hours = "0"
        record?.ot_hours = "1"
    }
    
    @IBAction func regPressed(_ sender: Any) {
        overTimeHoursbtn.isSelected = false
        rgHoursBtn.isSelected = true
        rgHours = "1"
        otHours = "0"
        record?.reg_hours = "1"
        record?.ot_hours = "0"
    }
    
    
    @IBAction func dc1Action(_ sender: DLRadioButton) {
        dc1Btn.isSelected = true
        dc2Btn.isSelected = false
        dc = "14"
        record?.dc = "14"
    }
    
    @IBAction func dc2Action(_ sender: DLRadioButton) {
        dc1Btn.isSelected = false
        dc2Btn.isSelected = true
        dc = "30"
        record?.dc = "30"
    }
    
    @IBAction func injryFreeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        record?.injury_free_day = sender.isSelected ? "1" : "0"
    }
    
    @IBAction func lockEntryButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        record?.emp_locked = sender.isSelected ? "1" : "0"
    }
    
    @IBAction func startTimeAction(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: { picker, value, index in
           let str = DateFormatter.localizedString(from: (value as! Date), dateStyle: .none, timeStyle: .short)
            sender.setTitle(str, for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            if self.isStarted{
                self.startTime = dateFormatter.string(from: (value as! Date))
                self.startBtn.setTitle(self.startTime, for: .normal)
                self.record?.start_time = self.startTime
                print(self.startTime)
            }
        }, cancel: { picker in
            
        }, origin: sender)
    }
    @IBAction func timeAction(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: { picker, value, index in
           let str = DateFormatter.localizedString(from: (value as! Date), dateStyle: .none, timeStyle: .short)
            sender.setTitle(str, for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            if self.isStarted{
                self.endTime = dateFormatter.string(from: (value as! Date))
                self.endBtn.setTitle(self.endTime, for: .normal)
                self.record?.end_time = self.endTime
                print(self.startTime)
            }
        }, cancel: { picker in
            
        }, origin: sender)
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        self.startAnimating()
        let rr = [record!]
        NetworkManager.jobBulkUpdate(id: userID, records: rr) { data, status in
            self.stopsAnimating()
            self.delegate?.passData()
            self.closeButtonAction()
        }
        
//        NetworkManager.jobUpdate(id: record?.id ?? "1", uid: "", job_number: record?.job_no ?? "", dc: dc, start_time: startTime, end_time: endTime, reg_hours: rgHours, otHours: otHours, injury_free_day:injFree , emp_locked: lock) { data, status in
//            if status{
//                self.stopsAnimating()
//                self.delegate?.passData()
//                self.closeButtonAction()
//            }
//        }
    }
    @IBAction func closeButtonAction(){
        self.fadeBackgroundAnimation(true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.holderView.frame = CGRect(x: 0, y:touchPoint.y, width: self.holderView.frame.size.width, height: self.holderView.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                UIView.animate(withDuration: 0.3) {
                    self.holderView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.holderView.frame.size.width, height: self.holderView.frame.size.height)
                }
                
                self.closeButtonAction()
                
            } else {
                UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .allowUserInteraction, animations: {
                    self.holderView.frame = CGRect(x: self.resetPoint.x, y: self.resetPoint.y, width: self.holderView.frame.size.width, height: self.holderView.frame.size.height)
                }) { (m) in
                }
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
