//
//  Date+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 24/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit


extension Date {
    
    func toString(_ formate : String,_ locale : String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self)
        
    }
    
    func getNumberOfDayBetweenDate(betweenDate : Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: self, to: betweenDate)
        return components.day!
    }
    
    func getNumberOfMinuteBetweenDate(betweenDate : Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.minute], from: betweenDate, to: self)
        if components.minute! < 0 {
            return components.minute! * -1
        }
        return components.minute!
    }
    
}
