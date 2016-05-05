//
//  FormUILabel.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-05.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormUILabel: UILabel
{
    dynamic public var _textColor: UIColor? {
        get { return super.textColor }
        set { textColor = newValue }
    }
    
    dynamic public var _font: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}
