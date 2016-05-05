//
//  ViewController.swift
//  FormsDemo
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit
import MCForms


class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let form = Form(defaultValues: ["bool1" : true, "choice1" : 1, "bool2" : false])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        form.addRowGroup(withTitle: "First section".uppercaseString) { (group) in
            group.addInputRow(FormBooleanRow(withQuestion: "Enable the matrix") { (formBooleanRow) in
                print(formBooleanRow)
                }, identifier: "bool1")
            
            group.addInputRow(FormMultipleChoiceRow(withQuestion: "Choose an option", optionsCount: 3, onSelectedIndexChanged: { (formChoiceRow) in
                print(formChoiceRow)
            }), identifier: "choice1")
            
            group.addInputRow(FormTextRow(withQuestion: "Enter your best sentance", onTextChangeClosure: { (formTextRow, changeTypek) in
                print(formTextRow)
            }), identifier: "text1")
        }
        
        form.addRowGroup(withTitle: "Second section".uppercaseString) { (group) in
            group.addInputRow(FormBooleanRow(withQuestion: "Question number four") { (formBooleanRow) in }, identifier: "bool2")
        }
        
        form.setupSuperview(superview: scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let formSize = form.layoutForm(withBoundingRect: CGSize(width: view.frame.size.width, height: .max),
                                       contentInsets: UIEdgeInsets(top: 30, left: 10, bottom: 10, right: 10))
        
        scrollView.frame = view.bounds
        scrollView.contentSize = formSize
    }
}
