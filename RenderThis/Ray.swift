//
//  Ray.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Ray {
    let origin: Point
    let direction: Vector
    let inv_direction: Vector
    
    init(origin: Point, direction: Vector) {
        self.origin = origin
        self.direction = normalize(direction)
        self.inv_direction = float3(1) / self.direction
    }
    
    func getPoint(at t: Float) -> Point {
        return origin + direction * t
    }
}
