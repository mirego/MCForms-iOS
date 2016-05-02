//
//  FormSection.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class MCFormSection
{
    let title: String
    private var rows = [MCFormRow]()
    
    init(withTitle title: String)
    {
        self.title = title
    }
    
    public func addInputRow(inputRow: MCFormRow)
    {
        rows.append(inputRow)
    }
}
