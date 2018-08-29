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

    override func viewDidLoad() {

    }

    @IBAction func searchFieldAction(_ sender: NSSearchFieldCell) {
        print("action")
    }

}

