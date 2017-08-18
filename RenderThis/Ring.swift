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
    var material: Material
    
    init(center: Point, normal: Normal, min_radius: Float, max_radius: Float, material: Material) {
        self.center = center
        self.normal = normalize(normal)
        self.min_radius = min_radius
        self.max_radius = max_radius
        self.material = material
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let t: Float = dot(-normal, ray.origin - center) / dot(normal, ray.direction)
        let d: Vector = ray.getPoint(at: t) - center
        let distance: Float = dot(d, d)
        if (distance > (min_radius * min_radius)) && (distance < (max_radius * max_radius)) {
            return hit_record.update(t: t, object: self)
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
