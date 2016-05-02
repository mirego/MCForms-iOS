//
//  FormBaseInput.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public protocol MCFormRow {
    var questionLabel: UILabel { get }
    var control: UIControl { get }
    var value: AnyObject { get }
    
    init(withQuestion question: String)
}
