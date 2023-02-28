//
//  AppDelegate.swift
//  HasterApp
//
//  Created by Usama Ali on 08/10/2022.
//

import UIKit
import SideMenuSwift
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       IQKeyboardManager.shared.enable = true
       if let data = UserDefaults.standard.object(forKey: "loginData") {
               openHome()
       }
       
       return true
   }
   
   func openHome(){
       let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
       let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
       let sideMenuController = SideMenuController(contentViewController: contentViewController, menuViewController: menuViewController)
       UIApplication.shared.windows.first?.rootViewController = sideMenuController
       
   }
   // MARK: UISceneSession Lifecycle
   
   func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       // Called when a new scene session is being created.
       // Use this method to select a configuration to create the new scene with.
       return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }
   
   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
   }
   
   
}

