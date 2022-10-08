//
//  Double+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 29/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

extension Double {
   
    var abbreviated: String {
        let abbrev = "KMBTPE"
        var numberString = abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
            } ?? String(self)
        
        if numberString.hasSuffix(".0") {
            numberString = String(numberString.dropLast(2))
        }
        
        return numberString
    }
}
