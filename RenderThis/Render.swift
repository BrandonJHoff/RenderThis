//
//  Render.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import Cocoa

func render() -> Film {
    let width: Int = 512
    let height: Int = 512
    
    let half_width: Float = Float(width / 2) + 0.5
    let half_height: Float = Float(height / 2) + 0.5
    
    let sphere1: Sphere = Sphere(center: Point(-1.5, 0.5, 1), radius: 1.2)
    let sphere2: Sphere = Sphere(center: Point(0, 0, 1.1), radius: 1.7)
    let sphere3: Sphere = Sphere(center: Point(1, -0.5, 1.2), radius: 1.9)
    let plane: Plane = Plane(origin: Point(0, -2, 0), normal: Normal(0, 1, 0))
    let camera: OrthoCamera = OrthoCamera(position: Point(0, 0, -2), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), xSize: 5.0, ySize: 5.0)
    
    let film: Film = Film(width: width, height: height)
    
    for i in 0..<width {
        for j in 0..<height {
            let x: Float = 2.0 * (Float(i) - half_width) / Float(width)
            let y: Float = 2.0 * (Float(j) - half_height) / Float(height)
            
            let ray: Ray = camera.makeRay(x: x, y: y)
            
            if sphere1.hit(withRay: ray) {
                film.setPixel(color: Color(1,0,0), atX: i, y: j)
            } else if sphere2.hit(withRay: ray) {
                film.setPixel(color: Color(0,1,0), atX: i, y: j)
            } else if sphere3.hit(withRay: ray) {
                film.setPixel(color: Color(0,0,1), atX: i, y: j)
            } else if plane.hit(withRay: ray) {
                film.setPixel(color: Color(1,0,1), atX: i, y: j)
            } else {
                film.setPixel(color: Color(1,1,1), atX: i, y: j)
            }
        }
    }
    
    return film
}

