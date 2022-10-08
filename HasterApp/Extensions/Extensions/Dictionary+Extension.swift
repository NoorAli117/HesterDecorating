//
//  Dictionary.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 16/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

extension Dictionary {
    
    var jsonString:String {
        var jsonString : String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            jsonString = String(data: jsonData, encoding: String.Encoding.utf8)! as String
        } catch {
            print(error.localizedDescription)
        }
        return jsonString
    }
    
    
    var queryString: String {
        var finalString: String = ""
        for (key,value) in self {
            finalString +=  "\(key)=\(value)&"
        }
        finalString = String(finalString.dropLast())
        if finalString == "=" {
            finalString = ""
        }
        return finalString
    }
}

