//
//  NSObject+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 31/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

extension NSObject {
    
    var className: String {
        get {
            return  NSStringFromClass(type(of: self))
        }
    }
    
}
