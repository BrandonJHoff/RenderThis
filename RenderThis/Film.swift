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
    let horizontal_resolution: Int
    let vertical_resolution: Int
    let width: Float
    let height: Float
    var pixels: [[Color]]
    
    init(horizontal_resolution: Int, vertical_resolution: Int, width: Float = 0, height: Float = 0) {
        self.horizontal_resolution = horizontal_resolution
        self.vertical_resolution = vertical_resolution
        self.width = width
        self.height = height
        pixels = Array(repeating: Array(repeating: Color(0), count: vertical_resolution), count: horizontal_resolution)
    }
    
    func setPixel(color: Color, atX x: Int, y: Int) {
        pixels[x][y] = color
    }
    
    func develop() -> NSImage {
        let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: horizontal_resolution, pixelsHigh: vertical_resolution, bitsPerSample: 8, samplesPerPixel: 3, hasAlpha: false, isPlanar: false, colorSpaceName: NSCalibratedRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 0)
        
        for i in 0..<pixels.count {
            for j in 0..<pixels[0].count {
                let y = pixels[0].count - 1 - j
                bitmap?.setColor(NSColor.init(calibratedRed: CGFloat(pixels[i][j].x), green: CGFloat(pixels[i][j].y), blue: CGFloat(pixels[i][j].z), alpha: 0.0), atX: i, y: y)
            }
        }
        
        return NSImage(cgImage: (bitmap?.cgImage)!, size: NSZeroSize)
    }

}
