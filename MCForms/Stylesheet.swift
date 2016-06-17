//
//  Stylesheet.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-05.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormStylesheet
{
    public static func applyAppearance()
    {
        FormRowsGroupTitleLabel.appearance()._textColor = UIColor.darkGrayColor()
        FormRowsGroupTitleLabel.appearance()._font = UIFont.boldSystemFontOfSize(25)
        
        FormRowQuestionLabel.appearance()._textColor = UIColor.darkGrayColor()
        FormRowQuestionLabel.appearance()._font = UIFont.systemFontOfSize(20)
        
        FormRowUITextField.appearance()._textColor = UIColor.blueColor()
        FormRowUITextField.appearance()._font = UIFont.systemFontOfSize(18)
        
        FormRowUISwitch.appearance()._onTintColor = UIColor.blueColor()
        FormRowUISwitch.appearance()._tintColor = UIColor.cyanColor()
        
        FormRowRadioButtons.appearance()._selectedButtonColor = UIColor.blueColor()
        FormRowRadioButtons.appearance()._buttonColor = UIColor.whiteColor()
        FormRowRadioButtons.appearance()._tileBackgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
    }
}
