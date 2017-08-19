//
//  Triangle.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/18/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Triangle: Object {
    let p0: Point
    let p1: Point
    let p2: Point
    let normal: Normal
    var material: Material
    
    init(p0: Point, p1: Point, p2: Point, material: Material) {
        self.p0 = p0
        self.p1 = p1
        self.p2 = p2
        self.normal = normalize(cross(p1 - p0, p2 - p0))
        self.material = material
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let e1: Vector = p1 - p0
        let e2: Vector = p2 - p0
        let r1: Vector = cross(ray.direction, e2)
        
        let denom: Float = dot(e1, r1)
        
        if abs(denom) < 0.001 {
            return false
        }
        
        let inv_denom: Float = 1.0 / denom
        
        let r2: Vector = ray.origin - p0
        let u: Float = dot(r2, r1) * inv_denom
        if u < 0 || u > 1 {
            return false
        }
        
        let r3: Vector = cross(r2, e1)
        let v: Float = dot(ray.direction, r3) * inv_denom
        if v < 0 || u + v > 1 {
            return false
        }
        
        let t: Float = dot(e2, r3) * inv_denom
        return hit_record.update(t: t, object: self)
    }
    
    func normal(atPoint point: Point) -> Normal {
        return normal
    }
}
