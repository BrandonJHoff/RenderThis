//
//  Ring.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/18/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Ring: Object {
    let center: Point
    let normal: Normal
    let min_radius: Float
    let max_radius: Float
    let min_radius_squared: Float
    let max_radius_squared: Float
    var material: Material
    
    init(center: Point, normal: Normal, min_radius: Float, max_radius: Float, material: Material) {
        self.center = center
        self.normal = normalize(normal)
        self.min_radius = min_radius
        self.max_radius = max_radius
        self.min_radius_squared = min_radius * min_radius
        self.max_radius_squared = max_radius * max_radius
        self.material = material
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let denom: Float = dot(normal, ray.direction)
        if abs(denom) > 0.0001 {
            let t: Float = dot(normal, center - ray.origin) / denom
            let d: Vector = ray.getPoint(at: t) - center
            let distance: Float = dot(d, d)
            if (distance > min_radius_squared) && (distance < max_radius_squared) {
                return hit_record.update(t: t, object: self)
            }
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
