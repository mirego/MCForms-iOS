//
//  FormUILabel.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-05.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

open class FormUILabel: UILabel
{
    fileprivate var textColorDefault: UIColor?
    dynamic open var _textColor: UIColor? {
        get { return textColorDefault }
        set { textColorDefault = newValue }
    }
    
    fileprivate var textColorOnError: UIColor?
    dynamic open var _textColorOnError: UIColor? {
        get { return textColorOnError }
        set { textColorOnError = newValue }
    }
    
    dynamic open var _font: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
    
    dynamic open var _textAlignment: NSTextAlignment {
        get { return self.textAlignment }
        set { self.textAlignment = newValue }
    }
    
    var inError: Bool = false {
        didSet {
            updateErrorAppearance()
        }
    }
    
    fileprivate func updateErrorAppearance()
    {
        textColor = inError ? (textColorOnError ?? textColorDefault) : textColorDefault
    }
}
