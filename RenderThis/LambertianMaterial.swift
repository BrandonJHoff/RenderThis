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
//            for object in scene.objects {
//                _ = object.hit(withRay: secondary_ray, recordWith: temp_hit_record)
//            }
            _ = scene.octree.intersect(withRay: secondary_ray, recordWith: temp_hit_record)
            
            if let object = temp_hit_record.object {
                final_color +=  object.material.shade(object: object, atPoint: secondary_ray.getPoint(at: temp_hit_record.t), inScene: scene, withIncomingRay: secondary_ray, atMaxDepth: depth + 1)
            } else {
                let t: Float = 0.5 * (ray.direction.y + 1.0)
                final_color += (1.0 - t) * Color(1) + t * Color(0.5, 0.7, 1)
            }
            
            final_color = final_color * cosphi
        }
        
        return final_color * color
    }
}
