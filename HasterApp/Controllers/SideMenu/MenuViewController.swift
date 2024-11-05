//
//  MenuViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 11/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit
import SideMenuSwift

class MenuViewController: UIViewController {
    
    var isDarkModeEnabled = false
    //private let disposeBag = DisposeBag()
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var profileImages: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var themeColor = UIColor.white
//    var sideMenuDataSource : [String] = ["SDS Documents", "Daily Task", "Job History","Safety Manual","Logout"]
//    var sideMenuDataSourceImages : [String] = ["sds","sds","jh","cp","lg"]
    
    var sideMenuDataSource : [String] = ["Safety Manual", "Chemical Inventory", "Logout"]
    var sideMenuDataSourceImages : [String] = ["cp","cp","lg"]
    override func viewDidLoad() {
        super.viewDidLoad()

        isDarkModeEnabled = SideMenuController.preferences.basic.position == .under
        sideMenuController?.delegate = self
        configureView()
        //setTopRightBackground()
        sideMenuController?.cache(viewControllerGenerator: {
            self.storyboard?.instantiateViewController(withIdentifier: "FeedsViewController")
        }, with: "1")
        versionLbl.text = "Version \(Bundle.main.releaseVersionNumber ?? "")"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("[Example] Menu did appear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func configureView() {
        view.backgroundColor = themeColor
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        confirmLogout()
    }
    private func logout() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        let loginVC = SigninViewController.instantiate(storyboardName: "Main")
        let navigationController = UINavigationController.init(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    private  func confirmLogout() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure, you want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "YES", style: .default) { _ in
                self.logout()
        }
        let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil
        )
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MenuViewController: SideMenuControllerDelegate {
    func sideMenuController(_ sideMenuController: SideMenuController,
                            animationControllerFrom fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BasicTransitionAnimator(options: .transitionFlipFromLeft, duration: 0.6)
    }

    func sideMenuController(_ sideMenuController: SideMenuController, willShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller will show [\(viewController)]")
    }

    func sideMenuController(_ sideMenuController: SideMenuController, didShow viewController: UIViewController, animated: Bool) {
        print("[Example] View controller did show [\(viewController)]")
    }

    func sideMenuControllerWillHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will hide")
    }

    func sideMenuControllerDidHideMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did hide.")
    }

    func sideMenuControllerWillRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu will reveal.")
    }

    func sideMenuControllerDidRevealMenu(_ sideMenuController: SideMenuController) {
        print("[Example] Menu did reveal.")
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuDataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SelectionCell
        
        cell.titleLabel?.textColor = isDarkModeEnabled ? .white : .black
        
        cell.titleLabel.text = sideMenuDataSource[indexPath.row]
        cell.bulaImages.image = UIImage(named: sideMenuDataSourceImages[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       // sideMenuController?.hideMenu()
        if indexPath.row == 0 {
            if let url = URL(string: "https://job.hpd-painters.com/downloads/") {
                UIApplication.shared.open(url)
            }
            
//            let loginVC = SDSViewController.instantiate(storyboardName: "Main")
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: true, completion: nil)
        }
//        else if indexPath.row == 1 {
//            let loginVC = CurrentPeriodViewController.instantiate(storyboardName: "Main")
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: true, completion: nil)
//        }
//        else if indexPath.row == 1 {
//            let loginVC = DailyTaskViewController.instantiate(storyboardName: "Main")
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: true, completion: nil)
//        }
//        else if indexPath.row == 2 {
//            let loginVC = JobHistoryViewController.instantiate(storyboardName: "Main")
//            loginVC.modalPresentationStyle = .fullScreen
//            present(loginVC, animated: true, completion: nil)
//        }
        else if indexPath.row == 1 {
            if let url = URL(string: "https://job.hpd-painters.com/chemical-inventory/") {
                UIApplication.shared.open(url)
            }
        }
        else{
            confirmLogout()
        }
        if let identifier = sideMenuController?.currentCacheIdentifier() {
            print("[Example] View Controller Cache Identifier: \(identifier)")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

class SelectionCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bulaImages: UIImageView!
    
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
