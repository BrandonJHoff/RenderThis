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
    var color: Color
    
    init(origin: Point, normal: Normal, color: Color) {
        self.origin = origin
        self.normal = normalize(normal)
        self.color = color
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        let t: Float = dot(normal, ray.origin - origin) / dot(normal, ray.direction)
        return hit_record.update(t: t, object: self)
    }
}
