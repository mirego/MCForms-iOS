//
//  FormRowUISwitch.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormRowUISwitch: UISwitch
{
    dynamic public var _onTintColor: UIColor? {
        get { return self.onTintColor }
        set { self.onTintColor = newValue }
    }
    
    dynamic public var _tintColor: UIColor? {
        get { return self.tintColor }
        set { self.tintColor = newValue }
    }
    
    dynamic public var _thumbTintColor: UIColor? {
        get { return self.thumbTintColor }
        set { self.thumbTintColor = newValue }
    }
}
