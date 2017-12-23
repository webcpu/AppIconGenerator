//
//  Asset.swift
//  AppIconSetGenerator
//
//  Created by Liang on 20/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation
import Cocoa
import HaskellSwift

struct Asset {
    static func makeAppIconSets(_ fileURL: URL) -> Result {
        let metass = [iosImageMetas, macosImageMetas]
        _ = map(makeAppIconSet(fileURL), metass)
        return Right(fileURL)
    }
    
    static func makeAppIconSet(_ fileURL: URL) -> ([ImageMetaData]) -> Result {
        return { metas in
            _ = writeContensFile(metas)
            _ = resizeImages(metas, fileURL)
            return Right(fileURL)
        }
    }
    
    //MARK: - writeContentsFile
    static func writeContensFile(_ metas: [ImageMetaData]) -> Bool {
        let path = appIconFileURL(metas[0].os).appendingPathComponent("Contents.json").path
        let str  = createContensJSONString(metas)
        return writeFile(path, str)
    }
    
    static func createContensJSONString(_ metas: [ImageMetaData]) -> String {
        let str = createContentsDictionary(metas) >>>= dictionaryToData >>>= dataToJSONString
        return str ?? ""
    }
    
    static func createContentsDictionary(_ metas: [ImageMetaData]) -> [String: Any] {
        let images: [[String: Any]]   = map(createImageMeta, metas)
        let info: [String: Any]       = ["version" : 1, "author": "xcode"]
        let contents:  [String : Any] = ["images": images, "info" : info]
        return contents
    }
    
    static func createImageMeta(_ meta: ImageMetaData) -> [String: Any] {
        let len      = meta.len.cleanValue
        let size     = "\(len)x\(len)"
        let scale    = "\(meta.scale)x"
        return ["size": size, "idiom": meta.idiom, "filename": meta.filename, "scale": scale]
    }
    
    static func dictionaryToData(_ dict: Any) -> Data? {
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }
    
    static func dataToJSONString(_ data: Data) -> String? {
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    //MARK: - resizeImages
    static func resizeImages(_ metas: [ImageMetaData], _ fileURL: URL) -> Result {
        for meta in metas {
            _ = resizeImage(fileURL, meta)
        }
        return Right(fileURL)
    }
    
    static func resizeImage(_ fileURL: URL, _ metaData: ImageMetaData) -> URL? {
        let load      = { url in NSImage(contentsOf: url) }
        let w         = CGFloat(metaData.len * Float(metaData.scale))
        let h         = w
        let resize    = { image in resizeNSImage(image, w, h) }
        let url       = appIconFileURL(metaData.os).appendingPathComponent(metaData.filename)
        return fileURL >>>= load >>>= resize >>>= imageToBitmap >>>= bitmapToPNGData >>>= writePNGFile(url)
    }
    
    static func imageToBitmap(_ image: NSImage) -> NSBitmapImageRep? {
        let data   = image.tiffRepresentation!
        let bitmap = NSBitmapImageRep(data: data)
        bitmap?.pixelsWide = Int(image.size.width)
        bitmap?.pixelsHigh = Int(image.size.height)
        return bitmap
    }
    
    static func writePNGFile(_ url: URL) -> (Data) -> URL? {
        return { data in
            writeImageFile(data)(url)
        }
    }
    
    static func resizeNSImage(_ image: NSImage, _ width: CGFloat, _ height: CGFloat) -> NSImage? {
        let frame = NSRect(x: 0, y: 0, width: width, height: height)
        guard let representation = image.bestRepresentation(for: frame, context: nil, hints: nil) else {
            return nil
        }
        
        let size     = NSSize(width: width, height: height)
        let newImage = NSImage(size: size, flipped: false, drawingHandler: { (_) -> Bool in
            return representation.draw(in: frame)
        })
        
        return newImage
    }
    
    static func prepareAssetsOutputDirectory(_ fileURL: URL) -> Result {
        return Right(fileURL) >>>= removeAssetsOutputDirectory >>>= createAppIconDirectories
    }
    
    static func removeAssetsOutputDirectory(_ fileURL: URL) -> Result {
        let path = assetsOutputFileURL().path
        do {
            try FileManager.default.removeItem(atPath: path)
        }
        catch let error as NSError {
            print(error)
        }
        return Right(fileURL)
    }
    
    static func createAppIconDirectories(_ fileURL: URL) -> Result {
        _ = map(createAppIconDirectory, ["iOS", "macOS"])
        return Right(fileURL)
    }
    
    static func createAppIconDirectory(_ os: String) -> Bool {
        let url = appIconFileURL(os)
        return createDirectory(url.path)
    }
}

func assetsOutputFileURL() -> URL {
    return URL(fileURLWithPath: NSHomeDirectory() + "/Downloads/AppIconGeneratorOutput/")
}

func appIconFileURL(_ os: String) -> URL {
    let path = assetsOutputFileURL().path + "/" + os + "/Assets.xcassets/AppIcon.appiconset/"
    return URL(fileURLWithPath: path)
}

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
