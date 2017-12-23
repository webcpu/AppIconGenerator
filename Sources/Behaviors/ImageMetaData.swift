//
//  ImageMetaData.swift
//  AppIconSetGenerator
//
//  Created by Liang on 20/12/2017.
//  Copyright © 2017 unhcartedworks.com. All rights reserved.
//

import Foundation

typealias ImageMetaData = (len: Float, idiom: String, filename: String, scale: Int, os: String)

let iosImageMetas: [ImageMetaData] = [
    (20,   "iphone",  "iPhone Notification 20pt@2x.png", 2, "iOS"),
    (20,   "iphone",  "iPhone Notification 20pt@3x.png", 3, "iOS"),
    (29,   "iphone",  "iPhone Settings 29pt@2x.png",     2, "iOS"),
    (29,   "iphone",  "iPhone Settings 29pt@3x.png",     3, "iOS"),
    (40,   "iphone",  "iPhone Spotlight 40pt@2x.png",    2, "iOS"),
    (40,   "iphone",  "iPhone Spotlight 40pt@3x.png",    3, "iOS"),
    (60,   "iphone",  "iPhone App 60pt@2x.png",          2, "iOS"),
    (60,   "iphone",  "iPhone App 60pt@3x.png",          3, "iOS"),
    (20,   "ipad",    "iPad Notification 20pt.png",      1, "iOS"),
    (20,   "ipad",    "iPad Notification 20pt@2x.png",   2, "iOS"),
    (29,   "ipad",    "iPad Settings 29pt.png",          1, "iOS"),
    (29,   "ipad",    "iPad Settings 29pt@2x.png",       2, "iOS"),
    (40,   "ipad",    "iPad Spotlight 40pt.png",         1, "iOS"),
    (40,   "ipad",    "iPad Spotlight 40pt@2x.png",      2, "iOS"),
    (76,   "ipad",    "iPad App 76pt.png",               1, "iOS"),
    (76,   "ipad",    "iPad App 76pt@2x.png",            2, "iOS"),
    (83.5, "ipad",    "iPad Pro App 83,5pt@2x.png",      2, "iOS"),
    (1024, "ios-marketing", "App Store 1024pt.png",      1, "iOS")
]

let macosImageMetas: [ImageMetaData] = [
    (16,    "mac",  "mac 16pt.png",     1, "macOS"),
    (16,    "mac",  "mac 16pt@2x.png",  2, "macOS"),
    (32,    "mac",  "mac 32pt.png",     1, "macOS"),
    (32,    "mac",  "mac 32pt@2x.png",  2, "macOS"),
    (128,   "mac",  "mac 128pt.png",    1, "macOS"),
    (128,   "mac",  "mac 128pt@2x.png", 2, "macOS"),
    (256,   "mac",  "mac 256pt.png",    1, "macOS"),
    (256,   "mac",  "mac 256pt@2x.png", 2, "macOS"),
    (512,   "mac",  "mac 512pt.png",    1, "macOS"),
    (512,   "mac",  "mac 512pt@2x.png", 2, "macOS")
]
