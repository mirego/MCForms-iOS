//
//  FormTextInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class FormTextRow: MCFormRow
{
    let textField = UITextField()
    
    public var questionLabel = UILabel()
    public var control: UIControl {
        return textField
    }
    public var value: AnyObject {
        return textField.text ?? ""
    }
    
    required public init(withQuestion question: String)
    {
        questionLabel.text = question
    }
}
