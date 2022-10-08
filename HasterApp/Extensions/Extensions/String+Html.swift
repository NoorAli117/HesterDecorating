//
//  String+Html.swift
//  SheApp
//
//  Created by SSASoft on 23/05/2018.
//  Copyright © 2018 MH. All rights reserved.
//

import UIKit

extension String {
    
    func htmlToAttributedString() -> NSAttributedString {
        
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
