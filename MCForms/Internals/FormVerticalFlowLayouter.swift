//
//  FormLayouter.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-03.
//  Copyright © 2016 Mirego. All rights reserved.
//

import Foundation

public class FormVerticalFlowLayouter: FormLayouter
{
    var rowsSectionSpacing: CGFloat = 20
    var rowsGroupSpacing: CGFloat = 15
    var rowsSpacing: CGFloat = 15
    var rowQuestionControlSpacing: CGFloat = 10
    var rowAccessoryViewRightPadding: CGFloat = 0
    
    public init()
    {
        
    }
    
    public func layoutFormRowsGroups(formRowsGroups: [FormRowsGroup], boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        var insets = contentInsets
        var totalGroupsHeight: CGFloat = 0
        
        for formRowsGroup in formRowsGroups {
            let size = layoutFormRowsGroup(formRowsGroup, boundingRect: boundingRect, contentInsets: insets)
            
            insets = UIEdgeInsets(top: insets.top + size.height + rowsSectionSpacing, left: insets.left, bottom: insets.bottom, right: insets.right)
            
            totalGroupsHeight = totalGroupsHeight + size.height + rowsSectionSpacing
        }
        
        return CGSize(width: boundingRect.width, height: totalGroupsHeight)
    }
    
    public func layoutFormRowsGroup(formRowsGroup: FormRowsGroup, boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        let maxSize = CGSize(width: boundingRect.width - contentInsets.left - contentInsets.right,
                             height: boundingRect.height - contentInsets.top - contentInsets.bottom)
        
        let titleLabelSize = formRowsGroup.titleLabel.sizeThatFits(maxSize)
        formRowsGroup.titleLabel.frame = CGRect(x: contentInsets.left, y: contentInsets.top, width: maxSize.width, height: titleLabelSize.height)
        
        let commentLabelSize = formRowsGroup.commentLabel.sizeThatFits(maxSize)
        let commentTopOffset = CGRectGetMaxY(formRowsGroup.titleLabel.frame) + (commentLabelSize.height > 0 ? 5 : 0)
        formRowsGroup.commentLabel.frame = CGRect(x: contentInsets.left, y: commentTopOffset, width: maxSize.width, height: commentLabelSize.height)
        
        var totalRowsHeight: CGFloat = 0
        var newInset = UIEdgeInsets(top: CGRectGetMaxY(formRowsGroup.commentLabel.frame) + rowsGroupSpacing, left: contentInsets.left, bottom: contentInsets.bottom, right: contentInsets.right)
        
        for formRow in formRowsGroup.rows {
            let rowSize = layoutFormRow(formRow, boundingRect: boundingRect, contentInsets: newInset)
            
            newInset = UIEdgeInsets(top: newInset.top + rowSize.height, left: newInset.left, bottom: newInset.bottom, right: newInset.right)
            
            totalRowsHeight = totalRowsHeight + rowSize.height
        }
        
        return CGSize(width: maxSize.width, height: titleLabelSize.height + totalRowsHeight + rowsGroupSpacing)
    }
    
    public func layoutFormRow(formRow: FormRow, boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        let maxSize = CGSize(width: boundingRect.width - contentInsets.left - contentInsets.right,
                             height: boundingRect.height - contentInsets.top - contentInsets.bottom)
        
        var maxQuestionLabelWidth = maxSize.width
        for accessoryView in formRow.accessoryViews {
            maxQuestionLabelWidth = maxQuestionLabelWidth - accessoryView.frame.size.width - 10
        }
        maxQuestionLabelWidth = maxQuestionLabelWidth - (formRow.accessoryViews.count > 0 ? 10 : 0)
        
        let questionLabelSize = formRow.questionLabel.sizeThatFits(CGSize(width: maxQuestionLabelWidth, height: maxSize.height))
        formRow.questionLabel.frame = CGRect(x: contentInsets.left, y: contentInsets.top, width: questionLabelSize.width, height: questionLabelSize.height)
        
        var accesoryViewXPosition = maxSize.width + contentInsets.left
        var maxAccessoryHeight: CGFloat = 0
        var maxAccessoryY: CGFloat = 0
        for (_, accessoryView) in formRow.accessoryViews.enumerate() {
            let accessoryYOffset = contentInsets.top - ((accessoryView.frame.size.height - questionLabelSize.height) / 2.0)
            let origin = CGPoint(x: accesoryViewXPosition - accessoryView.frame.size.width, y: accessoryYOffset)
            accessoryView.frame = CGRect(origin: origin, size: accessoryView.frame.size)
            accesoryViewXPosition = accesoryViewXPosition - accessoryView.frame.size.width - 10
            maxAccessoryHeight = max(maxAccessoryHeight, accessoryView.frame.size.height)
            maxAccessoryY = max(maxAccessoryY, CGRectGetMaxY(accessoryView.frame))
        }
        
        var topOffset: CGFloat = 0
        if formRow.questionLabel.frame.height >= maxAccessoryHeight {
            topOffset = formRow.questionLabel.frame.height + rowQuestionControlSpacing
        } else {
            topOffset = maxAccessoryY - contentInsets.top + rowQuestionControlSpacing
        }
        
        let controlSize = formRow.control.sizeThatFits(CGSize(width: maxSize.width, height: maxSize.height - topOffset))
        formRow.control.frame = CGRect(x: contentInsets.left, y: contentInsets.top + topOffset, width: controlSize.width, height: controlSize.height)
        
        var lastView: UIView = formRow.control
        
        if let footerView = formRow.footerView where !footerView.hidden {
            topOffset = topOffset + formRow.control.frame.height + rowQuestionControlSpacing
            
            UIView.performWithoutAnimation({ 
                footerView.frame =  CGRectMake(contentInsets.left, contentInsets.top + topOffset, footerView.frame.size.width, footerView.frame.size.height)
            })
            
            
            lastView = footerView
        }
        
        return CGSize(width: maxSize.width, height: CGRectGetMaxY(lastView.frame) - contentInsets.top + rowsSpacing + rowQuestionControlSpacing)
    }
}
