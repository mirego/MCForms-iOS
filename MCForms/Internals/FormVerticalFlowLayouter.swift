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
    let rowsSectionSpacing: CGFloat = 20
    let rowsGroupSpacing: CGFloat = 10
    let rowsSpacing: CGFloat = 5
    
    public func layoutFormRowsGroups(formRowsGroups: [FormRowsGroup], boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        var insets = contentInsets
        var totalGroupsHeight: CGFloat = insets.top + insets.bottom
        
        for formRowsGroup in formRowsGroups {
            let size = layoutFormRowsGroup(formRowsGroup, boundingRect: boundingRect, contentInsets: insets)
            
            insets = UIEdgeInsets(top: insets.top + size.height + rowsSectionSpacing, left: insets.left, bottom: insets.bottom, right: insets.right)
            
            totalGroupsHeight = totalGroupsHeight + size.height + rowsSectionSpacing
        }
        
        return CGSize(width: boundingRect.width, height: totalGroupsHeight)
    }
    
    internal func layoutFormRowsGroup(formRowsGroup: FormRowsGroup, boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        let maxSize = CGSize(width: boundingRect.width - contentInsets.left - contentInsets.right,
                             height: boundingRect.height - contentInsets.top - contentInsets.bottom)
        
        let titleLabelSize = formRowsGroup.titleLabel.sizeThatFits(maxSize)
        formRowsGroup.titleLabel.frame = CGRect(x: contentInsets.left, y: contentInsets.top, width: titleLabelSize.width, height: titleLabelSize.height)
        
        var totalRowsHeight: CGFloat = 0
        var newInset = UIEdgeInsets(top: CGRectGetMaxY(formRowsGroup.titleLabel.frame) + rowsGroupSpacing, left: contentInsets.left, bottom: contentInsets.bottom, right: contentInsets.right)
        
        for formRow in formRowsGroup.rows {
            let rowSize = layoutFormRow(formRow, boundingRect: boundingRect, contentInsets: newInset)
            
            newInset = UIEdgeInsets(top: newInset.top + rowSize.height, left: newInset.left, bottom: newInset.bottom, right: newInset.right)
            
            totalRowsHeight = totalRowsHeight + rowSize.height
        }
        
        return CGSize(width: maxSize.width, height: titleLabelSize.height + totalRowsHeight + rowsGroupSpacing)
    }
    
    internal func layoutFormRow(formRow: FormRow, boundingRect: CGSize, contentInsets: UIEdgeInsets) -> CGSize
    {
        let maxSize = CGSize(width: boundingRect.width - contentInsets.left - contentInsets.right,
                             height: boundingRect.height - contentInsets.top - contentInsets.bottom)
        
        let questionLabelSize = formRow.questionLabel.sizeThatFits(maxSize)
        formRow.questionLabel.frame = CGRect(x: contentInsets.left, y: contentInsets.top, width: questionLabelSize.width, height: questionLabelSize.height)
        
        let topOffset = formRow.questionLabel.frame.height
        
        let controlSize = formRow.control.sizeThatFits(CGSize(width: maxSize.width, height: maxSize.height - topOffset))
        formRow.control.frame = CGRect(x: contentInsets.left, y: contentInsets.top + topOffset, width: controlSize.width, height: controlSize.height)
        
        return CGSize(width: maxSize.width, height: questionLabelSize.height + controlSize.height + rowsSpacing)
    }
}
