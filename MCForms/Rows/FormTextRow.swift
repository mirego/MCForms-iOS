//
//  FormTextInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation


open class FormTextRow: FormBaseRow, FormRow
{
    public enum ChangeType {
        case editingChanged
        case editingEnded
    }
    
    let textField = FormRowUITextField()
    
    open var control: UIControl {
        return textField
    }
    override open var value: AnyObject? {
        get {
            return textField.text as AnyObject?? ?? "" as AnyObject?
        }
        set {
            if let newValue = newValue as? String {
                textField.text = newValue
            } else {
                textField.text = ""
            }
        }
    }
    
    open var onTextChangeClosure: ((FormTextRow, ChangeType) -> Void)?
    
    public init(withQuestion question: String, placeholderText: String = "", onTextChangeClosure:((FormTextRow, ChangeType) -> Void)? = nil)
    {
        self.onTextChangeClosure = onTextChangeClosure
        
        super.init(withQuestion: question)
        
        textField.placeholder = placeholderText
        textField.addTarget(self, action: #selector(FormTextRow.textEditingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(FormTextRow.textEditingEnded), for: .editingDidEnd)
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
    }
    
    @objc internal func textEditingChanged(_ sender:UIButton!)
    {
        onTextChangeClosure?(self, .editingChanged)
    }
    
    @objc internal func textEditingEnded(_ sender:UIButton!)
    {
        onTextChangeClosure?(self, .editingEnded)
    }
}
