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
    
    let half_width: Float = Float(width / 2) + 0.5
    let half_height: Float = Float(height / 2) + 0.5
    
    let sphere1: Sphere = Sphere(center: Point(-1.5, 0.5, 1), radius: 1.2)
    let sphere2: Sphere = Sphere(center: Point(0, 0, 1.1), radius: 1.7)
    let sphere3: Sphere = Sphere(center: Point(1, -0.5, 1.2), radius: 1.9)
    let plane: Plane = Plane(origin: Point(0, -2, 0), normal: Normal(0, 1, 0))
    let camera: OrthoCamera = OrthoCamera(position: Point(0, 0, -2), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), xSize: 5.0, ySize: 5.0)
    
    var pixels: [[Color]] = Array(repeating: Array(repeating: Color(0), count: height), count: width)
    
    for i in 0..<width {
        for j in 0..<height {
            let x: Float = 2.0 * (Float(i) - half_width) / Float(width)
            let y: Float = 2.0 * (Float(j) - half_height) / Float(height)
            
            let ray: Ray = makeRay(camera: camera, x: x, y: y)
            
            if hit(ray: ray, with: sphere1) {
                pixels[i][j] = Color(1, 0, 0)
            } else if hit(ray: ray, with: sphere2) {
                pixels[i][j] = Color(0, 1, 0)
            } else if hit(ray: ray, with: sphere3) {
                pixels[i][j] = Color(0, 0, 1)
//            } else if hit(ray: ray, with: plane) > 0.001 {
//                pixels[i][j] = Color(1, 0, 1)
            } else {
                pixels[i][j] = Color(1, 1, 1)
            }
        }
    }
    
    return pixels
}

func convert(pixels: [[Color]]) -> NSImage {
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: 512, pixelsHigh: 512, bitsPerSample: 8, samplesPerPixel: 3, hasAlpha: false, isPlanar: false, colorSpaceName: NSDeviceRGBColorSpace, bytesPerRow: 0, bitsPerPixel: 0)
    
    for i in 0..<pixels.count {
        for j in 0..<pixels[0].count {
            let y = pixels[0].count - 1 - j
            bitmap?.setColor(NSColor.init(deviceRed: CGFloat(pixels[i][j].x), green: CGFloat(pixels[i][j].y), blue: CGFloat(pixels[i][j].z), alpha: 0.0), atX: i, y: y)
        }
    }
    
    return NSImage(cgImage: (bitmap?.cgImage)!, size: NSZeroSize)
}
