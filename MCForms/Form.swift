//
//  Form.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class Form
{
    public var layouter: FormLayouter = FormVerticalFlowLayouter()
    public let keyboardDismissGesture = UITapGestureRecognizer()
    
    private(set) var groups = [FormRowsGroup]()
    private let defaultValues: [String : AnyObject]?
    
    public init(defaultValues: [String : AnyObject]? = nil)
    {
        self.defaultValues = defaultValues
        keyboardDismissGesture.addTarget(self, action: #selector(Form.keyboardTapGestureTriggered))
        
        FormStylesheet.applyAppearance()
    }
    
    public func addRowGroup(withTitle title: String, setup: (FormRowsGroup) -> Void)
    {
        let group = FormRowsGroupImpl(withTitle: title)
        setup(group)
        
        if let defaultValues = defaultValues {
            group.applyValues(defaultValues)
        }
        groups.append(group)
    }
    
    /**
     * (Optional) Should be called to add all the views/controls in the view hierarchy.
     * You can choose not to call it and manage the subviews yourself
     */
    public func setupSuperview(superview superview: UIView)
    {
        for group in groups {
            superview.addSubview(group.titleLabel)
            for row in group.rows {
                superview.addSubview(row.questionLabel)
                superview.addSubview(row.control)
            }
        }
        
        superview.addGestureRecognizer(keyboardDismissGesture)
    }
    
    /**
     * (Optional) Should be called to layout the form.
     * If `setupSuperview()` is called, then call this method as well.
     *
     * @return the final size, can be used to adjuste contentSize of a scrollView
     */
    public func layoutForm(withBoundingRect maxSize: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        return layouter.layoutFormRowsGroups(groups, boundingRect: maxSize, contentInsets: contentInsets)
    }
    
    /**
     * Returns a dictionary of values [identifier : rowValue]
     */
    public func currentValues() -> [String : AnyObject]
    {
        var values = [String : AnyObject]()
        
        for group in groups  {
            values.update((group as! FormRowsGroupImpl).currentValues())
        }
                
        return values
    }
    
    @objc internal func keyboardTapGestureTriggered()
    {
        for group in groups  {
            (group as! FormRowsGroupImpl).endEditing()
        }
    }
    
}