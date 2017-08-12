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

func hit(ray: Ray, with sphere: Sphere) -> Bool {
    let temp = ray.origin - sphere.center
    
    let a = dot(ray.direction, ray.direction)
    let b = 2.0 * dot(ray.direction, temp)
    let c = dot(temp, temp) - sphere.radius * sphere.radius
    
    let discriminant = (b * b) - (4.0 * a * c)
    
    if discriminant > 0 {
        let d = sqrt(discriminant)
        var t = (-1.0 * b - d) / (2.0 * a)
        
        if t < 0.0001 {
            t = (-1.0 * b + d) / (2.0 * a)
        }
        
        if (t < 0.0001) || t > 10000.0 {
            return false
        }
        
        return true
    }
    return false
}
