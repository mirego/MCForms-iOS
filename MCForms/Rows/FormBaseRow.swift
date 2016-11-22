//
//  FormBaseRow.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

open class FormBaseRow
{
    open var required: Bool = false
    
    open var questionLabel = FormRowQuestionLabel()
    
    open var value: AnyObject? {
        return nil
    }
    
    open var accessoryViews = [UIView]() {
        willSet {
            for (_, view) in accessoryViews.enumerated() {
                view.removeFromSuperview()
            }
        }
        didSet {
            if let superview = questionLabel.superview {
                for (_, view) in accessoryViews.enumerated() {
                    superview.addSubview(view)
                }
            }
        }
    }
    
    open var footerView: UIView? {
        willSet {
            footerView?.removeFromSuperview()
        }
        didSet {
            if let footerView = footerView, let superview = questionLabel.superview {
                superview.addSubview(footerView)
            }
        }
    }
    
    init(withQuestion question: String)
    {
        questionLabel.numberOfLines = 0
        questionLabel.text = question        
    }
    
    internal func validate() -> Bool
    {
        let isValid = (required ? value != nil : true)
        questionLabel.inError = !isValid
        
        return isValid
    }
}
