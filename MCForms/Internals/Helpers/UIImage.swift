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
    class func imageWithColor(color: UIColor) -> UIImage
    {
        let rect = CGRectMake(0.0, 0.0, 5.0, 5.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
}
