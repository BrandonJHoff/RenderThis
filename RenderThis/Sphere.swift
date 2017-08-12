//
//  Sphere.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

struct Sphere {
    let center: Point
    let radius: Double
}

// formula from:
// https://en.wikipedia.org/wiki/Line–sphere_intersection
func hit(ray: Ray, with sphere: Sphere) -> Bool {
    let v = ray.origin - sphere.center
    let b = dot(ray.direction, v)
    let c = dot(v, v) - sphere.radius * sphere.radius
    let discriminant = (b * b) - c
    
    if discriminant > 0 {
        let d = sqrt(discriminant)
        var t = -b - d
        
        if t < 0.0001 {
            t = -b + d
        }
        
        if (t < 0.0001) || t > 10000.0 {
            return false
        }
        
        return true
    }
    return false
}
