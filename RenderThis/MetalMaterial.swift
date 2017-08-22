//
//  MetalMaterial.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/21/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class MetalMaterial: Material {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func shade(object: Object, atPoint point: Point, inScene scene: Scene, withIncomingRay ray: Ray, atMaxDepth depth: Int) -> Color {
        var final_color: Color = Color(0)
        let temp_hit_record = HitRecord()
        let N: Normal = object.normal(atPoint: point)
        let secondary_ray = Ray(origin: point, direction: ray.direction - 2 * dot(ray.direction, N) * N)
        let cosphi: Float = dot(secondary_ray.direction, N)
        
        if cosphi > 0 && depth < 50 {
            for object in scene.objects {
                _ = object.hit(withRay: secondary_ray, recordWith: temp_hit_record)
            }
            
            if let object = temp_hit_record.object {
                final_color +=  object.material.shade(object: object, atPoint: secondary_ray.getPoint(at: temp_hit_record.t), inScene: scene, withIncomingRay: secondary_ray, atMaxDepth: depth + 1)
            } else {
                final_color += Color(1)
            }
        }
        
        return final_color * color
    }
}
