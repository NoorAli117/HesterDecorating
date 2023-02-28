//
//  SigninViewController.swift
//  HesterDecorating
//
//  Created by Usama Ali on 28/06/2021.
//com.nitaj.WeCare-Seeker
//Usama.HesterDecorating

import UIKit
import SideMenuSwift
class SigninViewController: BaseViewController {
    
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = UserDefaults.standard.object(forKey: "username") as? String {
            self.userTF.text = username
        }
        if let pass = UserDefaults.standard.object(forKey: "password") as? String {
            self.passTF.text = pass
        }
        
    }
    @IBAction func forgotAction(_ sender: Any) {
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if userTF.text!.isEmpty || passTF.text!.isEmpty {
            self.showAlert(title: "", message: "Please Enter UserName and password")
        }
        else{
            UserDefaults.standard.set(userTF.text!, forKey: "username")
            UserDefaults.standard.set(passTF.text!, forKey: "password")
            callLogin()
        }
    }
    
    
    func callLogin(){
        self.startAnimating()
        NetworkManager.signinRequest(userName: userTF.text!, password: passTF.text!) {userdata, status in
            self.stopsAnimating()
            if let user = userdata?.user{
                UserDefaults.standard.set(user.data?.iD, forKey: "userid")
                do{
                    let colorAsData = try NSKeyedArchiver.archivedData(withRootObject: user, requiringSecureCoding: true)
                    UserDefaults.standard.set(colorAsData, forKey: "userObj")
                    UserDefaults.standard.synchronize()
                }catch (let error){
                    #if DEBUG
                        print("Failed to convert UIColor to Data : \(error.localizedDescription)")
                    #endif
                }
                
                self.openHome()
            }
            else{
                self.showAlert(title: "", message: userdata?.message ?? "")
            }
        }
    }
    
    func openHome(){
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
        let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
        UIApplication.shared.windows.first?.rootViewController = sideMenuController
    }
}
