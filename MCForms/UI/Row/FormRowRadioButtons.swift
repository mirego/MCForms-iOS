//
//  FormRowRadioButtons.swift
//  MCForms
//
//  Created by Gulam Moledina on 2016-05-04.
//  Copyright © 2016 Mirego. All rights reserved.
//

import UIKit

open class FormRowRadioButtons: UIControl
{
    var buttons: [UIButton]!
    var tileLayers: [CALayer]!
    
    let padding: CGFloat = 5
    let buttonEdgeSize: CGFloat = 40
    
    fileprivate var selectedButtonColor: UIColor = UIColor.green
    dynamic open var _selectedButtonColor: UIColor {
        get { return selectedButtonColor }
        set {
            selectedButtonColor = newValue
            updateSelectedImageAndColor()
        }
    }
    
    fileprivate var selectedButtonImage: UIImage?
    dynamic open var _selectedButtonImage: UIImage? {
        get { return selectedButtonImage }
        set {
            selectedButtonImage = newValue
            updateSelectedImageAndColor()
        }
    }
    
    func updateSelectedImageAndColor()
    {
        var image: UIImage!
        if let selectedButtonImage = selectedButtonImage {
            image = selectedButtonImage.imageWithBackgroundColor(selectedButtonColor, size: CGSize(width: buttonEdgeSize, height: buttonEdgeSize))
        } else {
            image = UIImage.imageWithColor(selectedButtonColor)
        }
        
        for button in buttons {
            button.setBackgroundImage(image, for: .selected)
        }
    }
    
    fileprivate var buttonColor: UIColor = UIColor.white
    dynamic open var _buttonColor: UIColor {
        get { return buttonColor }
        set {
            buttonColor = newValue
            for button in buttons {
                button.setBackgroundImage(UIImage.imageWithColor(buttonColor), for: UIControlState())
            }
        }
    }
    
    dynamic open var _tileBackgroundColor: UIColor {
        get {
            if let tileLayers = tileLayers, let tile = tileLayers.first {
                return UIColor(cgColor:tile.backgroundColor!)
            }
            return UIColor.lightGray.withAlphaComponent(0.4)
        }
        set {
            for tile in tileLayers {
                tile.backgroundColor = newValue.cgColor
            }
        }
    }
    
    open var selectedIndex: Int? {
        get {
            for button in buttons where button.isSelected {
                return buttons.index(of: button)
            }
            return nil
        }
        set {
            if let newValue = newValue, buttons.count > newValue {
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
            tile.backgroundColor = tileBackgroundColor.cgColor
            layer.addSublayer(tile)
            tileLayers.append(tile)
            
            let button = UIButton(type: .custom)
            stylelizeButton(button)
            button.addTarget(self, action: #selector(FormRowRadioButtons.buttonTapped), for: .touchUpInside)
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
    
    override open func layoutSubviews()
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
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize
    {
        return CGSize(width: max(size.width, CGFloat(buttons.count) * (buttonEdgeSize + padding) + padding),
                      height: buttonEdgeSize + padding + padding)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        let hittedView = super.hitTest(point, with: event)
        if hittedView == self {
            for button in buttons {
                if button.frame.insetBy(dx: -10, dy: -10).contains(point) {
                    buttonTapped(button)
                    break
                }
            }
        }
        
        return hittedView
    }
    
    func buttonTapped(_ button: UIButton)
    {
        if !button.isSelected {
            selectButton(button)
        }
    }
    
    fileprivate func selectButton(_ newSelectedButton: UIButton?)
    {
        let currentSelectedIndex = selectedIndex
        
        for button in buttons {
            if let newSelectedButton = newSelectedButton, newSelectedButton == button {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
        
        if currentSelectedIndex != selectedIndex {
            sendActions(for: .valueChanged)
        }
    }
    
    fileprivate func stylelizeButton(_ button: UIButton)
    {
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage.imageWithColor(buttonColor), for: UIControlState())
        button.setBackgroundImage(UIImage.imageWithColor(selectedButtonColor), for: .selected)
    }
}
