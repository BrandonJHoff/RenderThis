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
    var material: Material
    
    init(center: Point, normal: Normal, radius: Float, material: Material) {
        self.center = center
        self.normal = normalize(normal)
        self.radius = radius
        self.material = material
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let t: Float = dot(-normal, ray.origin - center) / dot(normal, ray.direction)
        let d: Vector = ray.getPoint(at: t) - center
        if dot(d, d) < (radius * radius) {
            return hit_record.update(t: t, object: self)
        }
        return false
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
