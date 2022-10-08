//
//  BaseViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 29/06/2021.
//

import UIKit
import RappleProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func startAnimating(){
        RappleActivityIndicatorView.startAnimating()
    }
    func stopsAnimating(){
        RappleActivityIndicatorView.stopAnimation()
    }

}
