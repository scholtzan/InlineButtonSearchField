//
//  InlineButtonSearchField.swift
//  InlineButtonSearchField
//
//  Created by Anna Scholtz on 28.08.18.
//  Copyright © 2018 scholtzan. All rights reserved.
//

import Cocoa
import Swift



class InlineButtonSearchField: NSSearchField {
    let countLabel = NSTextField()
    var rightPadding: CGFloat = 0  // offset for next button
    let defaultButtonWidth: CGFloat = 22

    var resultCount: Int? {
        didSet {
            if let newCount = resultCount {
                countLabel.stringValue = String(newCount) + " matches"
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
        countLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -defaultButtonWidth - rightPadding).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    override func rectForCancelButton(whenCentered isCentered: Bool) -> NSRect {
        let rect = super.rectForCancelButton(whenCentered: isCentered)

        return NSRect(x: rect.origin.x - rightPadding, y: rect.origin.y, width: rect.width, height: rect.height)
    }

    override func rectForSearchText(whenCentered isCentered: Bool) -> NSRect {
        let rect = super.rectForSearchText(whenCentered: isCentered)
        var width = rect.width - rect.origin.x - rightPadding - defaultButtonWidth

        return NSRect(x: rect.origin.x, y: rect.origin.y, width: width, height: rect.height)
    }
}

