//
//  CornerRadius.swift
//  ExtraMiles
//
//  Created by Usama Ali on 05/02/2021.
//

import Foundation
import  UIKit
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}