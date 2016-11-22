//
//  Stylesheet.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-05.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

open class FormStylesheet
{
    open static func applyAppearance()
    {
        FormRowsGroupTitleLabel.appearance()._textColor = UIColor.darkGray
        FormRowsGroupTitleLabel.appearance()._font = UIFont.boldSystemFont(ofSize: 25)
        
        FormRowQuestionLabel.appearance()._textColor = UIColor.darkGray
        FormRowQuestionLabel.appearance()._textColorOnError = UIColor.red
        FormRowQuestionLabel.appearance()._font = UIFont.systemFont(ofSize: 20)
        
        FormRowUITextField.appearance()._textColor = UIColor.blue
        FormRowUITextField.appearance()._font = UIFont.systemFont(ofSize: 18)
        
        FormRowUISwitch.appearance()._onTintColor = UIColor.blue
        FormRowUISwitch.appearance()._tintColor = UIColor.cyan
        
        FormRowRadioButtons.appearance()._selectedButtonColor = UIColor.blue
        FormRowRadioButtons.appearance()._buttonColor = UIColor.white
        FormRowRadioButtons.appearance()._tileBackgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
}
