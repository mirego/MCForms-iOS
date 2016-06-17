//
//  FormSection.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

internal class FormRowsGroupImpl: FormRowsGroup
{
    var titleLabel = FormRowsGroupTitleLabel()
    
    var rows: [FormRow] {
        return rowsObjects
    }
    
    private var rowsObjects = [FormRow]()
    private var rowsIdentifiers = [String]()
    
    init(withTitle title: String)
    {
        titleLabel.text = title
        titleLabel.numberOfLines = 0
    }
    
    func addInputRow(inputRow: FormRow, identifier: String)
    {
        rowsObjects.append(inputRow)
        rowsIdentifiers.append(identifier)
    }
    
    internal func endEditing()
    {
        for row in rows {
            row.control.endEditing(true)
            row.footerView?.endEditing(true)
        }
    }
    
    internal func applyValues(values: [String : AnyObject])
    {
        for index in 0..<rowsIdentifiers.count {
            let identifier = rowsIdentifiers[index]
            
            if let value = values[identifier] {
                var formRow = rowsObjects[index]
                formRow.value = value
            }
        }
    }
    
    internal func currentValues() -> [String : AnyObject]
    {
        var values = [String : AnyObject]()
        
        for index in 0..<rowsIdentifiers.count {
            var formRow = rowsObjects[index]
            if let value = formRow.value {
                let identifier = rowsIdentifiers[index]
                values[identifier] = value
            }
        }
        
        return values
    }
}
