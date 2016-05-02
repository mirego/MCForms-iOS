//
//  FormBooleanInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class FormBooleanRow: MCFormRow
{
    let switchControl = UISwitch()
    
    public var questionLabel = UILabel()
    public var control: UIControl {
        return switchControl
    }
    public var value: AnyObject {
        return switchControl.on
    }
    
    required public init(withQuestion question: String)
    {
        questionLabel.text = question
    }
}