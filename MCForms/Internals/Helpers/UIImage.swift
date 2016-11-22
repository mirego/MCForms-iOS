//
//  UIImage.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

extension UIImage
{
    class func imageWithColor(_ color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
    }
    
    func imageWithBackgroundColor(_ color: UIColor, size: CGSize) -> UIImage
    {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size)
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let imageRect = CGRect(origin: CGPoint(x: (size.width - self.size.width) / 2.0, y: (size.height - self.size.height) / 2.0), size: self.size)
        draw(in: imageRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
