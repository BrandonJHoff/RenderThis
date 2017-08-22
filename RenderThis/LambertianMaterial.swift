//
//  LambertianMaterial.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class LambertianMaterial: Material {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func shade(object: Object, atPoint point: Point, inScene scene: Scene, withIncomingRay ray: Ray, atMaxDepth depth: Int) -> Color {
        var final_color: Color = Color(0,0,0)
        let temp_hit_record = HitRecord()
        let N: Normal = object.normal(atPoint: point)
        let secondary_ray = Ray(origin: point, direction: uniformSampleHemishpere())
        let cosphi: Float = dot(N, secondary_ray.direction)
        
        if cosphi > 0 && depth < 50 {
            for object in scene.objects {
                _ = object.hit(withRay: secondary_ray, recordWith: temp_hit_record)
            }
            
            if let object = temp_hit_record.object {
                final_color +=  object.material.shade(object: object, atPoint: secondary_ray.getPoint(at: temp_hit_record.t), inScene: scene, withIncomingRay: secondary_ray, atMaxDepth: depth + 1)
            } else {
                final_color += Color(1)
            }
            
            final_color = final_color * cosphi
        }
        
        return final_color * color
    }
    
    func uniformSampleHemishpere() -> Vector {
        let r1: Float = Float(drand48())
        let r2: Float = Float(drand48())
        
        let sinTheta: Float = sqrtf(1 - r1 * r1);
        let phi: Float = Float(2.0) * Float.pi * r2;
        let x: Float = sinTheta * cosf(phi);
        let z: Float = sinTheta * sinf(phi);
        
        return Vector(x, r1, z);
    }
}
