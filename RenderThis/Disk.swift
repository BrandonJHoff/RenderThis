//
//  Disk.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/18/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Disk: Object {
    let center: Point
    let normal: Normal
    let radius: Float
    let radius_squared: Float
    var material: Material
    var bbox: BBox
    
    init(center: Point, normal: Normal, radius: Float, material: Material) {
        self.center = center
        self.normal = normalize(normal)
        self.radius = radius
        self.radius_squared = radius * radius
        self.material = material
        self.bbox = BBox(min: center - Vector(radius), max: center + Vector(radius))
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let denom: Float = dot(normal, ray.direction)
        if abs(denom) > 0.0001 {
            let t: Float = dot(normal, center - ray.origin) / denom
            let d: Vector = ray.getPoint(at: t) - center
            if dot(d, d) < radius_squared {
                return hit_record.update(t: t, object: self)
            }
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
