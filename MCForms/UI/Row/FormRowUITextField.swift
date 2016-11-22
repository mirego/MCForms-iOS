//
//  FormRowQuestionUITextField.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

open class FormRowUITextField: UITextField
{
    dynamic open var _textColor: UIColor? {
        get { return super.textColor }
        set { textColor = newValue }
    }
    
    dynamic open var _font: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
    
    dynamic open var _borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect
    {
        let rect = super.textRect(forBounds: bounds)
        let finalRect = rect.insetBy(dx: 5, dy: 2)
        return finalRect
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect
    {
        return self.textRect(forBounds: bounds)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        return self.textRect(forBounds: bounds)
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize
    {
        let defaultSize = super.sizeThatFits(size)
        return CGSize(width: size.width, height: defaultSize.height)
    }
}
