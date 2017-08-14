//
//  Film.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import Cocoa

class Film {
    let width: Int
    let height: Int
    var pixels: [[Color]]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        pixels = Array(repeating: Array(repeating: Color(0), count: height), count: width)
    }
    
    func setPixel(color: Color, atX x: Int, y: Int) {
        pixels[x][y] = color
    }
    
    func develop() -> NSImage {
        let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 3, hasAlpha: false, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 0)
        
        for i in 0..<pixels.count {
            for j in 0..<pixels[0].count {
                let y = pixels[0].count - 1 - j
                bitmap?.setColor(NSColor.init(deviceRed: CGFloat(pixels[i][j].x), green: CGFloat(pixels[i][j].y), blue: CGFloat(pixels[i][j].z), alpha: 0.0), atX: i, y: y)
            }
        }
        
        return NSImage(cgImage: (bitmap?.cgImage)!, size: NSZeroSize)
    }

}
