//
//  UIView+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 17/12/2019.
//  Copyright © 2019 MOHRE. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func dropShadow(radius:CGFloat) {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowRadius = 2.0
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1833280854)
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func dropShadow1(radius:CGFloat) {
        layer.shadowOpacity = 2
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 2.0
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1833280854)
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}

