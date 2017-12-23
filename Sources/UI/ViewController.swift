//
//  ViewController.swift
//  AppIconGenerator
//
//  Created by Liang on 18/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSDraggingDestination, NSWindowDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        let window = self.view.window
        window?.styleMask.remove(.resizable)
        window?.delegate = self
    }
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        dump(sender)
        return true
    }

}

