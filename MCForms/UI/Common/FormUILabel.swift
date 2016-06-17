//
//  FormUILabel.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-05.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormUILabel: UILabel
{
    private var textColorDefault: UIColor?
    dynamic public var _textColor: UIColor? {
        get { return textColorDefault }
        set { textColorDefault = newValue }
    }
    
    private var textColorOnError: UIColor?
    dynamic public var _textColorOnError: UIColor? {
        get { return textColorOnError }
        set { textColorOnError = newValue }
    }
    
    dynamic public var _font: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
    
    dynamic public var _textAlignment: NSTextAlignment {
        get { return self.textAlignment }
        set { self.textAlignment = newValue }
    }
    
    var inError: Bool = false {
        didSet {
            updateErrorAppearance()
        }
    }
    
    private func updateErrorAppearance()
    {
        textColor = inError ? (textColorOnError ?? textColorDefault) : textColorDefault
    }
}
