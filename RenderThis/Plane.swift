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
    
    init(origin: Point, normal: Normal, material: Material) {
        self.origin = origin
        self.normal = normalize(normal)
        self.material = material
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let denom: Float = dot(normal, ray.direction)
        if abs(denom) > 0.0001 {
            let t: Float = dot(normal, origin - ray.origin) / denom
            return hit_record.update(t: t, object: self)
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
