//
//  FormBaseRow.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class FormBaseRow
{
    public var questionLabel = FormRowQuestionLabel()
    
    init(withQuestion question: String)
    {
        questionLabel.numberOfLines = 0
        questionLabel.text = question        
    }
}
