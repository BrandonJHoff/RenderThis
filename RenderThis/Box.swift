//
//  Box.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/18/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

class Box: Object {
    let min: Point
    let max: Point
    var material: Material
    
    init(min: Point, max: Point, material: Material) {
        self.min = min
        self.max = max
        self.material = material
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
        
        let has_hit_t1 = hit_record.update(t: tmin, object: self)
        let has_hit_t2 = hit_record.update(t: tmax, object: self)
        
        return has_hit_t1 || has_hit_t2
    }
    
    func normal(atPoint point: Point) -> Normal {
        let epsilon: Float = 0.001;
        
        if abs(min.x - point.x) < epsilon {
            return Normal(-1, 0, 0)
        } else if abs(max.x - point.x) < epsilon {
            return Normal(1, 0, 0)
        } else if abs(min.y - point.y) < epsilon {
            return Normal(0, -1, 0)
        } else if abs(max.y - point.y) < epsilon {
            return Normal(0, 1, 0)
        } else if abs(min.z - point.z) < epsilon {
            return Normal(0, 0, -1)
        } else {
            return Normal(0, 0, 1)
        }
    }
}
