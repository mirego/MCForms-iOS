//
//  FormTextInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation


public class FormTextRow: FormBaseRow, FormRow
{
    public enum ChangeType {
        case EditingChanged
        case EditingEnded
    }
    
    let textField = FormRowUITextField()
    
    public var control: UIControl {
        return textField
    }
    override public var value: AnyObject? {
        get {
            return textField.text ?? ""
        }
        set {
            if let newValue = newValue as? String {
                textField.text = newValue
            } else {
                textField.text = ""
            }
        }
    }
    
    public var onTextChangeClosure: ((FormTextRow, ChangeType) -> Void)?
    
    public init(withQuestion question: String, placeholderText: String = "", onTextChangeClosure:((FormTextRow, ChangeType) -> Void)? = nil)
    {
        self.onTextChangeClosure = onTextChangeClosure
        
        super.init(withQuestion: question)
        
        textField.placeholder = placeholderText
        textField.addTarget(self, action: #selector(FormTextRow.textEditingChanged), forControlEvents: .EditingChanged)
        textField.addTarget(self, action: #selector(FormTextRow.textEditingEnded), forControlEvents: .EditingDidEnd)
        textField.layer.borderColor = UIColor.darkGrayColor().CGColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
    }
    
    @objc internal func textEditingChanged(sender:UIButton!)
    {
        onTextChangeClosure?(self, .EditingChanged)
    }
    
    @objc internal func textEditingEnded(sender:UIButton!)
    {
        onTextChangeClosure?(self, .EditingEnded)
    }
}
