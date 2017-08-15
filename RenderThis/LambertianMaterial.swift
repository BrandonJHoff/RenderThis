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
    let kd: Float
    
    init(color: Color, kd: Float) {
        self.color = color
        self.kd = kd
    }
    
    func shade(object: Object, atPoint point: Point, inScene scene: Scene, withIncomingRay ray: Ray) -> Color {
        var N: Normal = object.normal(atPoint: point)
        let costheta: Float = dot(N, ray.direction)
        
        N = (costheta > 0) ? -N : N
        
        var final_color: Color = Color(0,0,0)
        
        let temp_hit_record = HitRecord()
        for light in scene.lights {
            let (light_direction, light_color) = light.getLightInfo(withObjectPoint: point)
            let shadow_ray: Ray = Ray(origin: point, direction: light_direction)
            let cosphi: Float = dot(N, light_direction)
            
            if cosphi > 0 {
                temp_hit_record.reset()
                var has_hit: Bool = false
                for object in scene.objects {
                    if object.hit(withRay: shadow_ray, recordWith: temp_hit_record) {
                        has_hit = true
                        continue
                    }
                }
                
                if !has_hit {
                    final_color += light_color * kd * cosphi
                }
            }
        }
        
        
        return final_color * color
    }
}
