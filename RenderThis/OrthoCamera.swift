//
//  OrthoCamera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/12/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class OrthoCamera: Camera {
    let position: Point
    let u: Vector
    let v: Vector
    let w: Vector
    
    init(position: Point, lookAt: Point, up: Vector, xSize: Float, ySize: Float) {
        self.position = position
        w = normalize(lookAt - position)
        u = normalize(cross(up, w)) * xSize
        v = normalize(cross(w, u)) * ySize
    }
    
    func makeRay(x: Float, y: Float) -> Ray {
        let p: Point = position + x * u + y * v
        return Ray(origin: p, direction: w)
    }
}
