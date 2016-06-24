//
//  FormChoiceInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation
import UIKit

public class FormMultipleChoiceRow: FormBaseRow, FormRow
{
    let radioButtonsControl: FormRowRadioButtons
    
    public var control: UIControl {
        return radioButtonsControl
    }
    override public var value: AnyObject? {
        get {
            return radioButtonsControl.selectedIndex
        }
        set {
            if let newValue = newValue as? Int {
                radioButtonsControl.selectedIndex = newValue
            } else {
                radioButtonsControl.selectedIndex = 0
            }
        }
    }
    
    public var onSelectedIndexChangedClosure: ((FormMultipleChoiceRow) -> Void)?

    required public init(withQuestion question: String, optionsCount: Int, onSelectedIndexChanged:((FormMultipleChoiceRow) -> Void)? = nil)
    {
        onSelectedIndexChangedClosure = onSelectedIndexChanged
        radioButtonsControl = FormRowRadioButtons(optionsCount: optionsCount)
        
        super.init(withQuestion: question)
        
        radioButtonsControl.addTarget(self, action: #selector(FormMultipleChoiceRow.choiceValueChanged), forControlEvents: .ValueChanged)
    }
    
    @objc internal func choiceValueChanged(sender:UIButton!)
    {
        onSelectedIndexChangedClosure?(self)
    }
}
