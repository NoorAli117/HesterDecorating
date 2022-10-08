//
//  UIViewController+Extension.swift
//  GitHub Resume
//
//  Created by Shahbaz Khan on 24/11/2019.

import UIKit
//import NVActivityIndicatorView


extension UIViewController   {
    class func instantiate<T: UIViewController>(storyboardName: String) -> T {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        
    }
    
    var hasSafeArea: Bool {
        guard
            #available(iOS 11.0, tvOS 11.0, *)
        else {
            return false
        }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    
    
    
    func showAppAlertWithMessage(_ message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "", message:
                                                        message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message:
                                                        message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?{
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
//    var activity: NVActivityIndicatorView {
//        if self.view.viewWithTag(99999) is NVActivityIndicatorView{
//            return self.view.viewWithTag(99999) as! NVActivityIndicatorView
//        }else {
//            let activity = NVActivityIndicatorView(frame: CGRect(x: 0, y:  0, width: 100, height: 100), type: .ballSpinFadeLoader, color: UIColor.darkBlueAppColor, padding: 20)
//
//            activity.tag = 99999
//            return activity
//        }
//    }
    
//    func showActivityIndicator(){
//        let ac = self.activity
//        DispatchQueue.main.async {
//            self.view.isUserInteractionEnabled = false
//            appDelegate.appFlow.mainViewController?.tabbarContainer.isUserInteractionEnabled = false
//
//            self.view.addSubview(ac)
//            ac.center = CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
//            ac.startAnimating()
//        }
//
//    }
//    func hideActivityIndicator(){
//
//
//        DispatchQueue.main.async {
//            appDelegate.appFlow.mainViewController?.tabbarContainer.isUserInteractionEnabled = true
//            self.view.isUserInteractionEnabled = true
//            let ac = self.activity
//            ac.stopAnimating()
//            ac.removeFromSuperview()
//            self.view.isUserInteractionEnabled = true
//        }
//    }
}





