//
//  InlineButtonSearchField.swift
//  InlineButtonSearchField
//
//  Created by Anna Scholtz on 28.08.18.
//  Copyright © 2018 scholtzan. All rights reserved.
//

import Cocoa
import Swift

class Label: NSTextField {
    init(title: String) {
        super.init(frame: .zero)
        self.stringValue = title
        self.isEditable = false
        self.isSelectable = false
        self.textColor = NSColor.labelColor
        self.backgroundColor = NSColor.clear
        self.lineBreakMode = .byClipping
        self.isBezeled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InlineButtonSearchField: NSSearchField {
    let countLabel = Label(title: "")
    var rightPadding: CGFloat = 0  // offset for next button
    let defaultButtonWidth: CGFloat = 22
    var inlineButtonSpacing: CGFloat = 2
    var labelConstraint: NSLayoutConstraint?

    var resultCount: Int? {
        didSet {
            if let newCount = resultCount {
                countLabel.stringValue = String(newCount)
                if self.stringValue != "" {
                    countLabel.isHidden = false
                }
            } else {
                countLabel.isHidden = true
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        centersPlaceholder = false
        sendsSearchStringImmediately = true

        self.addSubview(countLabel)
        countLabel.textColor = NSColor.lightGray
        countLabel.font = NSFont.systemFont(ofSize: 12)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        labelConstraint = countLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -defaultButtonWidth - rightPadding)
        labelConstraint?.isActive = true
        countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }

    override func rectForCancelButton(whenCentered isCentered: Bool) -> NSRect {
        let rect = super.rectForCancelButton(whenCentered: isCentered)

        return NSRect(x: rect.origin.x - rightPadding, y: rect.origin.y, width: rect.width, height: rect.height)
    }

    override func rectForSearchText(whenCentered isCentered: Bool) -> NSRect {
        let rect = super.rectForSearchText(whenCentered: isCentered)
        let width = rect.width - rect.origin.x - rightPadding - defaultButtonWidth

        return NSRect(x: rect.origin.x, y: rect.origin.y, width: width, height: rect.height)
    }

    func addInlineButton(title: String) -> NSButton {
        let button = NSButton(frame: NSRect(x: 0, y: 0, width: defaultButtonWidth, height: defaultButtonWidth))
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = title

        (button.cell as! NSButtonCell).bezelStyle = NSButton.BezelStyle.roundRect
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -inlineButtonSpacing - rightPadding).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: inlineButtonSpacing).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inlineButtonSpacing).isActive = true
        button.widthAnchor.constraint(equalToConstant: defaultButtonWidth).isActive = true
        rightPadding += defaultButtonWidth + inlineButtonSpacing
        labelConstraint?.isActive = false
        labelConstraint = countLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -defaultButtonWidth - rightPadding)
        labelConstraint?.isActive = true
        return button
    }
}

