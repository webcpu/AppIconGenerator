//
//  AppDelegate.swift
//  AppIconGenerator
//
//  Created by Liang on 18/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        return true
    }

}
