//
//  Bundle+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 02/01/2020.
//  Copyright © 2020 MOHRE. All rights reserved.
//

import UIKit

extension Bundle {
    static func localizeBundle(_ language : String) -> Bundle {
        let bundle  = Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!)!
        return bundle
    }
    
}
