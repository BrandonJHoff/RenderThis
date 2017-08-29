//
//  DielectricMaterial.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/22/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class DielectricMaterial: Material {
    let refractive_index: Float
    let color: Color
    
    init(refractive_index: Float) {
        self.refractive_index = refractive_index
        self.color = Color(1)
    }
    
    func shade(object: Object, atPoint point: Point, inScene scene: Scene, withIncomingRay ray: Ray, atMaxDepth depth: Int) -> Color {
        var final_color: Color = Color(0)
        let outward_normal: Normal
        let ni_over_no: Float
        let cosine: Float
        let temp_hit_record = HitRecord()
        let secondary_ray: Ray
        let N: Normal = object.normal(atPoint: point)
        let cosphi: Float = dot(ray.direction, N)
        
        if cosphi > 0 {
            outward_normal = -N
            ni_over_no = refractive_index
            cosine = refractive_index * cosphi / length(ray.direction)
        } else {
            outward_normal = N
            ni_over_no = 1.0 / refractive_index
            cosine = -cosphi / length(ray.direction)
        }
        
        let (to_refact, refracted) = refract(v: ray.direction, N: outward_normal, ni_over_no: ni_over_no, cosine: cosine)
        if to_refact {
            secondary_ray = Ray(origin: point, direction: refracted)
        } else {
            secondary_ray = Ray(origin: point, direction: ray.direction - 2 * cosphi * N)
        }
        
        if depth < 50 {
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
        }
        
        return final_color * color

    }
    
    func refract(v: Vector, N: Normal, ni_over_no: Float, cosine: Float) -> (Bool, Vector) {
        let cosphi: Float = dot(v, N)
        let discriminant = 1.0 - ni_over_no * ni_over_no * (1.0 - cosphi * cosphi)
        
        if discriminant <= 0 {
            return (false, Vector(0))
        }
        
        let reflect_probability = schlick(cosine: cosine)
        
        if Float(drand48()) < reflect_probability {
            return (false, Vector(0))
        }
        
        return (true, ni_over_no * (v - N * cosphi) - N * sqrtf(discriminant))
    }
    
    func schlick(cosine: Float) -> Float {
        var r0: Float = (1.0 - refractive_index) / (1.0 + refractive_index)
        r0 *= r0
        return r0 + (1.0 - r0) * powf((1.0 - cosine), 5)
    }
}
