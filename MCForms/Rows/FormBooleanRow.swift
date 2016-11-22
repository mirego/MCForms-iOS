//
//  FormBooleanInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

open class FormBooleanRow: FormBaseRow, FormRow
{
    open let switchControl = FormRowUISwitch()
    open var control: UIControl {
        return switchControl
    }
    
    override open var value: AnyObject? {
        get {
            return switchControl.isOn as AnyObject?
        }
        set {
            if let newValue = newValue as? Bool {
                switchControl.isOn = newValue
            } else {
                switchControl.isOn = false
            }
        }
    }
    
    open var onValueChangedClosure: ((FormBooleanRow) -> Void)?
    
    required public init(withQuestion question: String, onValueChanged:((FormBooleanRow) -> Void)? = nil)
    {
        onValueChangedClosure = onValueChanged
        
        super.init(withQuestion: question)
        
        switchControl.addTarget(self, action: #selector(FormBooleanRow.switchValueChanged), for: .valueChanged)
    }
    
    @objc internal func switchValueChanged(_ sender:UIButton!)
    {
        onValueChangedClosure?(self)
    }
}
