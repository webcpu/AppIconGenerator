//
//  MainView.swift
//  AppIconGenerator
//
//  Created by Liang on 18/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Cocoa
import Foundation
import HaskellSwift

class MainView: NSView {
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }
   
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .copy
    }
    
    override func draggingEnded(_ info: NSDraggingInfo) {
        progressIndicator.startAnimation(nil)
        _ = (Dragging.getInputFileURL(info) >>>= IconGenerator.generateAppIconAssets)
        progressIndicator.stopAnimation(nil)
    }
}

