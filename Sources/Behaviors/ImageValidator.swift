//
//  ImageValidator.swift
//  AppIconSetGenerator
//
//  Created by Liang on 20/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation
import Cocoa
import HaskellSwift

let minimalImageLength = 1024

struct ImageValidator {
    static func validateImage(_ fileURL: URL) -> Result {
        return Right(fileURL) >>>= validateImageType >>>= validateImageSize
    }
    
    static func validateImageType(_ fileURL: URL) -> Result {
        return isValidImageType(fileURL) ? Right(fileURL) : Left("input image should be in jpg or png format")
    }
    
    static func isValidImageType(_ fileURL: URL) -> Bool {
        let ext               = fileURL.pathExtension.lowercased()
        let allowedExtensions = ["jpg", "jpeg", "png"]
        return elem(ext, allowedExtensions)
    }
    
    static func validateFileExistence(_ fileURL: URL) -> Result {
        return fileExists(fileURL.path) ? Right(fileURL) : Left("\(fileURL.path) doesn't exist.")
    }
    
    static let INVALID_IMAGE = "input image's width and height should be equal, in addition, the width and height should not be less than \(minimalImageLength)"
    
    static func validateImageSize(_ fileURL: URL) -> Result {
        let isValid = isValidImageSize(fileURL)
        return isValid ? Right(fileURL) : Left(INVALID_IMAGE)
    }
    
    static func isValidImageSize(_ fileURL: URL) -> Bool {
        let image   = NSImage(contentsOf: fileURL)
        let rep     = image?.representations >>>= listToMaybe
        let width   = rep!.pixelsWide
        let height  = rep!.pixelsHigh
        return isJust(image) && width == height && Int(width) >= minimalImageLength
    }
}
