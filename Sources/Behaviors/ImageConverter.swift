//
//  ImageConverter.swift
//  AppIconSetGenerator
//
//  Created by Liang on 20/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation
import Cocoa
import HaskellSwift

struct ImageConverter {
    static func convertImage(_ fileURL: URL) -> Result {
        let ext = fileURL.pathExtension.lowercased()
        switch ext {
        case "jpg", "jpeg":
            return convertJPGToPNG(fileURL)
        default:
            return Right(fileURL)
        }
    }
    
    static func convertJPGToPNG(_ fileURL: URL) -> Result {
        let pngFileURL       = fileURL >>>= URLtoData >>>= dataToBitmap >>>= bitmapToPNGData >>>= writeConvertedPNGFile
        return isJust(pngFileURL) ? Right(pngFileURL!) : Left("Failed to convert image to png format")
    }
    
    static func URLtoData(_ url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
    
    static func dataToBitmap(_ data: Data) -> NSBitmapImageRep? {
        return NSBitmapImageRep(data: data)
    }
    
    static func temporaryFileURL() -> URL! {
        let directory = NSTemporaryDirectory()
        let fileName  = NSUUID().uuidString + ".png"
        return NSURL.fileURL(withPathComponents: [directory, fileName])
    }
    
    static func writeConvertedPNGFile(_ data: Data) -> URL? {
        return temporaryFileURL() >>>= writeImageFile(data)
    }
}

func bitmapToPNGData(_ imageRep: NSBitmapImageRep) -> Data? {
    return imageRep.representation(using: .png, properties: [:])
}

func writeImageFile(_ data: Data) -> (URL) -> URL? {
    return { (fileURL: URL) in
        do {
            try data.write(to: fileURL, options: .atomicWrite)
            return fileURL
        } catch {
            return nil
        }
    }
}
