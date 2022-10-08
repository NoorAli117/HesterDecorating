//
//  Dictionary.swift
//  Customer App
//
//  Created by mac on 09/03/2020.
//  Copyright © 2020 Shahbaz Khan. All rights reserved.
//

import Foundation
extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
