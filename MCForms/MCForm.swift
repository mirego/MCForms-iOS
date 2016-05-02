//
//  Form.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class MCForm
{
    private(set) var sections = [MCFormSection]()
    
    init()
    {
        
    }
    
    public func addSection(withTitle title: String, setup: (MCFormSection) -> ())
    {
        let section = MCFormSection(withTitle: title)
        setup(section)
        sections.append(section)
    }
}