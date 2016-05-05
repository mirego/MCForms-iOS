//
//  FormRowQuestionUITextField.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormRowUITextField: UITextField
{
    dynamic public var _textColor: UIColor? {
        get { return super.textColor }
        set { textColor = newValue }
    }
    
    dynamic public var _font: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
    
    dynamic public var _borderColor: UIColor {
        get { return UIColor(CGColor: layer.borderColor ?? UIColor.clearColor().CGColor) }
        set { layer.borderColor = newValue.CGColor }
    }
    
    public override func textRectForBounds(bounds: CGRect) -> CGRect
    {
        let rect = super.textRectForBounds(bounds)
        let finalRect = rect.insetBy(dx: 5, dy: 2)
        return finalRect
    }
    
    public override func placeholderRectForBounds(bounds: CGRect) -> CGRect
    {
        return self.textRectForBounds(bounds)
    }
    
    public override func editingRectForBounds(bounds: CGRect) -> CGRect
    {
        return self.textRectForBounds(bounds)
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize
    {
        let defaultSize = super.sizeThatFits(size)
        return CGSize(width: size.width, height: defaultSize.height)
    }
}
