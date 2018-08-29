//
//  MainViewController.swift
//  InlineButtonSearchFieldExample
//
//  Created by Anna Scholtz on 28.08.18.
//  Copyright © 2018 scholtzan. All rights reserved.
//

import Cocoa
import Swift


class MainViewController: NSViewController {
    @IBOutlet var searchField: InlineButtonSearchField!

    @objc func setRegex() {
        print("set regex")
    }

    @objc func setCaseSensitivity() {
        print("set case sensitivity")
    }

    override func viewDidLoad() {
        let regexButton = searchField.addInlineButton(title: ".*")
        regexButton.action = #selector(setRegex)
        regexButton.target = self
        let caseSensitivityButton = searchField.addInlineButton(title: "Aa")
        caseSensitivityButton.action = #selector(setCaseSensitivity)
        caseSensitivityButton.target = self
    }

    @IBAction func searchFieldAction(_ sender: NSSearchFieldCell) {
        searchField.resultCount = 5
    }

}

