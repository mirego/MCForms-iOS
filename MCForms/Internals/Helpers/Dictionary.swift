//
//  Dictionary.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

extension Dictionary
{
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
