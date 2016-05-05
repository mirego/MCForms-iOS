//
//  Protocols.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public protocol FormLayouter
{
    func layoutFormRowsGroups(formRowsGroups: [FormRowsGroup], boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
}

public protocol FormRowsGroup
{
    var titleLabel: FormRowsGroupTitleLabel { get }
    var rows: [FormRow] { get }
    
    func addInputRow(inputRow: FormRow, identifier: String)
}

public protocol FormRow
{
    var questionLabel: FormRowQuestionLabel { get }
    var control: UIControl { get }
    var value: AnyObject? { get set }
}
