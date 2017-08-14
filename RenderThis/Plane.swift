//
//  Plane.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/12/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Plane: Object {
    let origin: Point
    let normal: Normal
    
    init(origin: Point, normal: Normal) {
        self.origin = origin
        self.normal = normalize(normal)
    }
    
    func hit(withRay ray: Ray) -> Bool {
        let t: Float = dot(normal, ray.origin - origin) / dot(normal, ray.direction)
        return t > 0.001
    }
}
