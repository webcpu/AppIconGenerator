//
//  IconGenerator.swift
//  AppIconGenerator
//
//  Created by Liang on 19/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation
import Cocoa
import HaskellSwift

typealias Result = Either<String, URL>

struct IconGenerator {
    static func generateAppIconAssets(_ fileURL: URL) -> Result {
        let result =  Asset.prepareAssetsOutputDirectory(fileURL) >>>= ImageValidator.validateImage >>>= ImageConverter.convertImage >>>= generateAppIcon >>>= activateAppIconFolder
        _ = isLeft(result) ? showAlert(question: "Error", text: fromLeft(result)) : true
        return result
    }
    
    //MARK: - generateAppIcon
    static func generateAppIcon(_ fileURL: URL) -> Result {
        return Right(fileURL) >>>= ImageValidator.validateFileExistence >>>= Asset.makeAppIconSets
    }
    
    //MARK: - activateAppIconFolder
    static func activateAppIconFolder(_ fileURL: URL) -> Result {
        let outputFileURL = assetsOutputFileURL()
        NSWorkspace.shared.activateFileViewerSelecting([outputFileURL])
        return Right(outputFileURL)
    }
}

//MARK: alert
func showAlert(question: String, text: String) -> Bool {
    let alert = NSAlert()
    alert.messageText = question
    alert.informativeText = text
    alert.alertStyle = .warning
    alert.addButton(withTitle: "OK")
    return alert.runModal() == .alertFirstButtonReturn
}
