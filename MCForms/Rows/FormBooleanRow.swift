//
//  FormBooleanInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class FormBooleanRow: FormBaseRow, FormRow
{
    public let switchControl = FormRowUISwitch()
    public var control: UIControl {
        return switchControl
    }
    
    override public var value: AnyObject? {
        get {
            return switchControl.on
        }
        set {
            if let newValue = newValue as? Bool {
                switchControl.on = newValue
            } else {
                switchControl.on = false
            }
        }
    }
    
    private var onValueChangedClosure: ((FormBooleanRow) -> Void)?
    
    required public init(withQuestion question: String, onValueChanged:((FormBooleanRow) -> Void)? = nil)
    {
        onValueChangedClosure = onValueChanged
        
        super.init(withQuestion: question)
        
        switchControl.addTarget(self, action: #selector(FormBooleanRow.switchValueChanged), forControlEvents: .ValueChanged)
    }
    
    @objc internal func switchValueChanged(sender:UIButton!)
    {
        onValueChangedClosure?(self)
    }
}
