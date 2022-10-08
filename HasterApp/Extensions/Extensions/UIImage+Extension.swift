//
//  UIImage+Extension.swift
//  Tadbeer
//
//  Created by Shahbaz Khan on 13/01/2020.
//  Copyright © 2020 MOHRE. All rights reserved.
//

import UIKit

extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: [])
    }
         var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
        var png: Data? { pngData() }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
   
     
}
