//
//  BBox.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/27/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class BBox {
    let min: Point
    let max: Point
    let center: Point
    
    init(min: Point, max: Point) {
        self.min = min
        self.max = max
        self.center = (min + max) * 0.5
    }
    
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool {
        var t1: Float = (min.x - ray.origin.x) * ray.inv_direction.x
        var t2: Float = (max.x - ray.origin.x) * ray.inv_direction.x
        
        var tmin = Float.minimum(t1, t2)
        var tmax = Float.maximum(t1, t2)
        
        if tmin > tmax {
            return false
        }
        
        t1 = (min.y - ray.origin.y) * ray.inv_direction.y
        t2 = (max.y - ray.origin.y) * ray.inv_direction.y
        
        tmin = Float.maximum(tmin, Float.minimum(t1, t2))
        tmax = Float.minimum(tmax, Float.maximum(t1, t2))
        
        if tmin > tmax {
            return false
        }
        
        t1 = (min.z - ray.origin.z) * ray.inv_direction.z
        t2 = (max.z - ray.origin.z) * ray.inv_direction.z
        
        tmin = Float.maximum(tmin, Float.minimum(t1, t2))
        tmax = Float.minimum(tmax, Float.maximum(t1, t2))
        
        if tmin > tmax {
            return false
        }
        
//        let has_hit_t1 = hit_record.update(t: tmin, object: self)
//        let has_hit_t2 = hit_record.update(t: tmax, object: self)
        
//        return has_hit_t1 || has_hit_t2
        return true
    }
}

func surroundBBox(b1: BBox, b2: BBox) -> BBox {
    return BBox(min: min(b1.min, b2.min), max: max(b1.max, b2.max))
}
