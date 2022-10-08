//
//  CurrentTableViewCell.swift
//  HesterDecorating
//
//  Created by Usama Ali on 02/07/2021.
//

import UIKit
import DLRadioButton
class CurrentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var dclbl: UILabel!
    @IBOutlet weak var stlbl: UILabel!
    @IBOutlet weak var etlbl: UILabel!
    @IBOutlet weak var hourslbl: UILabel!
    @IBOutlet weak var rgImage: UIImageView!
    @IBOutlet weak var oTimage: UIImageView!
    @IBOutlet weak var injImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var jobnumLbl: UILabel!
    @IBOutlet weak var dc1Btn: DLRadioButton!
    @IBOutlet weak var dc2Btn: DLRadioButton!
    @IBOutlet weak var overTimeHoursbtn: DLRadioButton!
    @IBOutlet weak var rgHoursBtn: DLRadioButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var injFreeBtn: UIButton!
    @IBOutlet weak var lockBtn: UIButton!
    @IBOutlet weak var jobLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
