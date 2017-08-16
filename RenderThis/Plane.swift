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
        let t: Float = dot(-normal, ray.origin - origin) / dot(normal, ray.direction)
        return hit_record.update(t: t, object: self)
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
