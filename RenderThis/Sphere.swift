//
//  Sphere.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Sphere: Object {
    let center: Point
    let radius: Float
    let radius_squared: Float
    var material: Material
    var bbox: BBox
    
    init(center: Point, radius: Float, material: Material) {
        self.center = center
        self.radius = radius
        self.radius_squared = radius * radius
        self.material = material
        self.bbox = BBox(min: center - Vector(radius), max: center + Vector(radius))
    }
    
    // formula from:
    // https://en.wikipedia.org/wiki/Line–sphere_intersection
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        Stats.total_hit_tests += 1
        let v = ray.origin - center
        let b = dot(ray.direction, v)
        let c = dot(v, v) - radius_squared
        let discriminant = (b * b) - c
        
        if discriminant > 0 {
            let d = sqrt(discriminant)
            let has_hit_t1 = hit_record.update(t: -b - d, object: self)
            let has_hit_t2 = hit_record.update(t: -b + d, object: self)
            
            Stats.total_hits += 1
            return has_hit_t1 || has_hit_t2
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normalize(point - center)
    }
}


