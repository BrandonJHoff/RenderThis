//
//  Plane.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/12/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

struct Plane {
    let origin: Point
    let normal: Normal
    
    init(origin: Point, normal: Normal) {
        self.origin = origin
        self.normal = normalize(normal)
    }
}

func hit(ray: Ray, with plane: Plane) -> Float {
    let t: Float = dot(plane.normal, ray.origin - plane.origin) / dot(plane.normal, ray.direction)
    return t
}
