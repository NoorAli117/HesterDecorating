//
//  UINavigation+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 31/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func presentController(_ controller : UIViewController,_ animated : Bool,_ completion: (() -> Void)? = nil){
        self.present(controller, animated: animated, completion: completion)
    }
    
    func pushController(_ controller : UIViewController, _ animated : Bool)  {
        self.pushViewController(controller, animated: animated)
    }
    
    func managePushController(viewController: UIViewController,animated : Bool) {
        self.pushController(viewController, animated)
return
        var isFound: Bool = false
        if type(of: self.topViewController) == type(of: viewController) {
            // Do nothing
            
        } else {
            for controller in self.viewControllers {
                if type(of: controller) == type(of: viewController) {
                    self.popToViewController(controller, animated:animated)
                    isFound = true
                    break
                }
            }
            
            if (!isFound) {
                self.pushController(viewController, animated)
            }
        }
    }
}
