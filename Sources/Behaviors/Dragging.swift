//
//  Dragging.swift
//  AppIconSetGenerator
//
//  Created by Liang on 20/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation
import Cocoa
import HaskellSwift

struct Dragging {
    //MARK: - getInputFileURL
    static func getInputFileURL(_ sender: NSDraggingInfo) -> Result {
        let fileURL    = sender >>>= getInputFileURLs >>>= listToMaybe
        return isNothing(fileURL) ? Left("No Input File URL") : Right(fileURL!)
    }
    
    static func getInputFileURLs(_ sender: NSDraggingInfo) -> [URL]? {
        return _getInputFileURLs(sender.draggingPasteboard())
    }
    
    static func _getInputFileURLs(_ pasteBoard: NSPasteboard) -> [URL]? {
        let filteringOptions = [NSPasteboard.ReadingOptionKey.urlReadingContentsConformToTypes:NSImage.imageTypes]
        return pasteBoard.readObjects(forClasses: [NSURL.self], options: filteringOptions) as! [URL]?
    }

}
