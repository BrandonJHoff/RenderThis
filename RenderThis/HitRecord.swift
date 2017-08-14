//
//  HitRecord.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

class HitRecord {
    var t: Float
    var object: Object!
    
    init() {
        t = Float.greatestFiniteMagnitude
        object = nil
    }
    
    func reset() {
        t = Float.greatestFiniteMagnitude
        object = nil
    }
    
    func update(t hit_t: Float, object: Object) -> Bool {
        if hit_t > 0.001 && hit_t < t {
            t = hit_t
            self.object = object
            return true
        }
        return false
    }
}
