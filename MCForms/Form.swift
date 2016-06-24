//
//  Form.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation
import UIKit

public class Form: NSObject
{
    private static var allTapGestures = [UIGestureRecognizer]()
    
    public var layouter: FormLayouter = FormVerticalFlowLayouter()
    public let keyboardDismissGesture = UITapGestureRecognizer()
    
    private(set) public var groups = [FormRowsGroup]()
    private let defaultValues: [String : AnyObject]?
    
    private static var appearanceOnceToken: dispatch_once_t = 0
    
    public init(defaultValues: [String : AnyObject]? = nil)
    {
        self.defaultValues = defaultValues
        
        super.init()
        
        Form.allTapGestures.append(keyboardDismissGesture)
        keyboardDismissGesture.delegate = self
        keyboardDismissGesture.addTarget(self, action: #selector(Form.keyboardTapGestureTriggered))
    }
    
    override public class func initialize()
    {
        Form.applyDefaultAppearance(true)
    }
    
    deinit
    {
        Form.allTapGestures.removeAtIndex(Form.allTapGestures.indexOf(keyboardDismissGesture)!)
    }
    
    public static func applyDefaultAppearance()
    {
        applyDefaultAppearance(false)
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
                for accesoryView in row.accessoryViews {
                    superview.addSubview(accesoryView)
                }
                if let footerView = row.footerView {
                    superview.addSubview(footerView)
                }
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
    
    /**
     * Updates validation appearance
     */
    public func validate() -> Bool
    {
        return groups.reduce(true) { (valid, group) -> Bool in
            (group as! FormRowsGroupImpl).validate() && valid
        }
    }
    
    /**
     * Returns all rows in the form
     */
    public func allRows() -> [String : FormRow]
    {
        var rows = [String : FormRow]()
        
        for group in groups  {
            rows.update((group as! FormRowsGroupImpl).rowsById)
        }
        
        return rows
    }
    
    
    @objc internal func keyboardTapGestureTriggered()
    {
        for group in groups  {
            (group as! FormRowsGroupImpl).endEditing()
        }
    }
    
    private static func applyDefaultAppearance(onlyIfNotApplied: Bool)
    {
        if onlyIfNotApplied {
            dispatch_once(&appearanceOnceToken) {
                FormStylesheet.applyAppearance()
            }
        } else {
            FormStylesheet.applyAppearance()
            dispatch_once(&appearanceOnceToken) {}
        }
    }
}

extension Form : UIGestureRecognizerDelegate
{
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return Form.allTapGestures.contains(gestureRecognizer) && Form.allTapGestures.contains(otherGestureRecognizer)
    }
}
