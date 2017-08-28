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
    var material: Material
    var bbox: BBox
    
    init(origin: Point, normal: Normal, material: Material) {
        self.origin = origin
        self.normal = normalize(normal)
        self.material = material
        self.bbox = BBox(min: Point(0), max: Point(0))
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        Stats.total_hit_tests += 1
        let denom: Float = dot(normal, ray.direction)
        if abs(denom) > 0.0001 {
            let t: Float = dot(normal, origin - ray.origin) / denom
            Stats.total_hits += 1
            return hit_record.update(t: t, object: self)
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
