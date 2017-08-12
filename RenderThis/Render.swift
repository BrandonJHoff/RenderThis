//
//  Render.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import Cocoa

func render() -> [[Color]] {
    let width: Int = 512
    let height: Int = 512
    
    let half_width: Double = Double(width / 2) + 0.5
    let half_height: Double = Double(height / 2) + 0.5
    
    let sphere1: Sphere = Sphere(center: Point(-1.5, 0.5, 1), radius: 1.2)
    let sphere2: Sphere = Sphere(center: Point(0, 0, 1.1), radius: 1.7)
    let sphere3: Sphere = Sphere(center: Point(1, -0.5, 1.2), radius: 1.9)
    
    var pixels: [[Color]] = Array(repeating: Array(repeating: Color(0), count: height), count: width)
    
    for i in 0..<width {
        for j in 0..<height {
            let x: Double = 2.0 * (Double(i) - half_width) / Double(width)
            let y: Double = 2.0 * (Double(j) - half_height) / Double(height)
            
            let ray: Ray = Ray(origin: Point(0, 0, -2), direction: Vector(x, y, 1))
            
            if hit(ray: ray, with: sphere1) {
                pixels[i][j] = Color(0.2, 1, 1)
            } else if hit(ray: ray, with: sphere2) {
                pixels[i][j] = Color(1, 0.1, 1)
            } else if hit(ray: ray, with: sphere3) {
                pixels[i][j] = Color(1, 1, 0.2)
            } else {
                pixels[i][j] = Color(0.2, 0.2, 0.5)
            }
        }
    }
    
    return pixels
}

func convert(pixels: [[Color]]) -> NSImage {
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: 512, pixelsHigh: 512, bitsPerSample: 8, samplesPerPixel: 3, hasAlpha: false, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 0)
    
    for i in 0..<pixels.count {
        for j in 0..<pixels[0].count {
            bitmap?.setColor(NSColor.init(deviceRed: CGFloat(pixels[i][j].x), green: CGFloat(pixels[i][j].y), blue: CGFloat(pixels[i][j].z), alpha: 0.0), atX: i, y: j)
        }
    }
    
    return NSImage(cgImage: (bitmap?.cgImage)!, size: NSZeroSize)
}
