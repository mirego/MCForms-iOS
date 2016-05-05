//
//  FormRowRadioButtons.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

public class FormRowRadioButtons: UIControl
{
    var buttons: [UIButton]!
    var tileLayers: [CALayer]!
    
    let padding: CGFloat = 5
    let buttonEdgeSize: CGFloat = 44
    
    private var selectedButtonColor: UIColor = UIColor.greenColor()
    dynamic public var _selectedButtonColor: UIColor {
        get { return selectedButtonColor }
        set {
            selectedButtonColor = newValue
            for button in buttons {
                button.setBackgroundImage(UIImage.imageWithColor(selectedButtonColor), forState: .Selected)
            }
        }
    }
    
    private var buttonColor: UIColor = UIColor.whiteColor()
    dynamic public var _buttonColor: UIColor {
        get { return buttonColor }
        set {
            buttonColor = newValue
            for button in buttons {
                button.setBackgroundImage(UIImage.imageWithColor(buttonColor), forState: .Normal)
            }
        }
    }
    
    dynamic public var _tileBackgroundColor: UIColor {
        get {
            if let tileLayers = tileLayers, let tile = tileLayers.first {
                return UIColor(CGColor:tile.backgroundColor!)
            }
            return UIColor.lightGrayColor().colorWithAlphaComponent(0.4)
        }
        set {
            for tile in tileLayers {
                tile.backgroundColor = newValue.CGColor
            }
        }
    }
    
    public var selectedIndex: Int? {
        get {
            for button in buttons where button.selected {
                return buttons.indexOf(button)
            }
            return nil
        }
        set {
            if let newValue = newValue where buttons.count > newValue {
                selectButton(buttons[newValue])
            } else {
                selectButton(nil)
            }
        }
    }
    
    init(optionsCount: Int)
    {
        var buttons = [UIButton]()
        var tileLayers = [CALayer]()
        
        super.init(frame: .zero)
        
        let tileBackgroundColor = _tileBackgroundColor
        for _ in 1...optionsCount {
            let tile = CALayer()
            tile.backgroundColor = tileBackgroundColor.CGColor
            layer.addSublayer(tile)
            tileLayers.append(tile)
            
            let button = UIButton(type: .Custom)
            stylelizeButton(button)
            button.addTarget(self, action: #selector(FormRowRadioButtons.buttonTapped), forControlEvents: .TouchUpInside)
            addSubview(button)
            buttons.append(button)
        }
        
        self.buttons = buttons
        self.tileLayers = tileLayers
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        
        let totalButtonsWidth = buttonEdgeSize * CGFloat(buttons.count)
        let interPadding = max(padding, (frame.size.width - totalButtonsWidth) / CGFloat(buttons.count))
        let sidePadding = interPadding / 2.0
        
        for index in 0..<buttons.count {
            let button = buttons[index]
            let originX = CGFloat(index) * (buttonEdgeSize + interPadding) + sidePadding
            button.frame = CGRect(origin: CGPoint(x: originX, y: padding), size: CGSize(width: buttonEdgeSize, height: buttonEdgeSize))
            button.layer.cornerRadius = buttonEdgeSize / 2.0
            
            let tile = tileLayers[index]
            let tileWidth = buttonEdgeSize + interPadding - 1
            let tileOriginX = CGFloat(index) * (tileWidth + 1)
            tile.frame = CGRect(x: tileOriginX, y:0, width: tileWidth, height: frame.size.height)
        }
    }
    
    public override func sizeThatFits(size: CGSize) -> CGSize
    {
        return CGSize(width: max(size.width, CGFloat(buttons.count) * (buttonEdgeSize + padding) + padding),
                      height: buttonEdgeSize + padding + padding)
    }
    
    func buttonTapped(button: UIButton)
    {
        if !button.selected {
            selectButton(button)
        }
    }
    
    private func selectButton(newSelectedButton: UIButton?)
    {
        let currentSelectedIndex = selectedIndex
        
        for button in buttons {
            if let newSelectedButton = newSelectedButton where newSelectedButton == button {
                button.selected = true
            } else {
                button.selected = false
            }
        }
        
        if currentSelectedIndex != selectedIndex {
            sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    private func stylelizeButton(button: UIButton)
    {
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.darkGrayColor().CGColor
        button.layer.borderWidth = 1.0
        button.setBackgroundImage(UIImage.imageWithColor(buttonColor), forState: .Normal)
        button.setBackgroundImage(UIImage.imageWithColor(selectedButtonColor), forState: .Selected)
    }
}
