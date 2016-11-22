//
//  Form.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-02.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation
import UIKit

open class Form: NSObject
{
    private static var __applyAppearanceOnce: () = {
                FormStylesheet.applyAppearance()
            }()
    fileprivate static var allTapGestures = [UIGestureRecognizer]()
    
    open var layouter: FormLayouter = FormVerticalFlowLayouter()
    open let keyboardDismissGesture = UITapGestureRecognizer()
    
    fileprivate(set) open var groups = [FormRowsGroup]()
    fileprivate let defaultValues: [String : AnyObject]?
    
    fileprivate static var appearanceOnceToken: Int = 0
    
    public init(defaultValues: [String : AnyObject]? = nil)
    {
        self.defaultValues = defaultValues
        
        super.init()
        
        Form.allTapGestures.append(keyboardDismissGesture)
        keyboardDismissGesture.delegate = self
        keyboardDismissGesture.addTarget(self, action: #selector(Form.keyboardTapGestureTriggered))
    }
    
    override open class func initialize()
    {
        Form.applyDefaultAppearance(true)
    }
    
    deinit
    {
        Form.allTapGestures.remove(at: Form.allTapGestures.index(of: keyboardDismissGesture)!)
    }
    
    open static func applyDefaultAppearance()
    {
        applyDefaultAppearance(false)
    }
    
    open func addRowGroup(withTitle title: String, comment: String? = nil, setup: (FormRowsGroup) -> Void)
    {
        let group = FormRowsGroupImpl(withTitle: title, comment: comment)
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
    open func setupSuperview(superview: UIView)
    {
        for group in groups {
            superview.addSubview(group.titleLabel)
            superview.addSubview(group.commentLabel)
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
    open func layoutForm(withBoundingRect maxSize: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        return layouter.layoutFormRowsGroups(groups, boundingRect: maxSize, contentInsets: contentInsets)
    }
    
    /**
     * Returns a dictionary of values [identifier : rowValue]
     */
    open func currentValues() -> [String : AnyObject]
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
    open func validate() -> Bool
    {
        return groups.reduce(true) { (valid, group) -> Bool in
            (group as! FormRowsGroupImpl).validate() && valid
        }
    }
    
    /**
     * Returns all rows in the form
     */
    open func allRows() -> [String : FormRow]
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
        
        keyboardDismissGesture.view?.resignFirstResponder()
    }
    
    fileprivate static func applyDefaultAppearance(_ onlyIfNotApplied: Bool)
    {
        if onlyIfNotApplied {
            _ = Form.__applyAppearanceOnce
        } else {
            FormStylesheet.applyAppearance()
        }
    }
}

extension Form : UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return Form.allTapGestures.contains(gestureRecognizer) && Form.allTapGestures.contains(otherGestureRecognizer)
    }
}
