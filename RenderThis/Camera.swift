//
//  Camera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

protocol Camera {
    var film: Film { get set }
    var samples_per_pixel: Int { get set }
    func makeRay(i: Int, j: Int) -> Ray
}

func capture(scene: Scene, withCamera camera: Camera) {
    for i in 0..<camera.film.horizontal_resolution {
        for j in 0..<camera.film.vertical_resolution {
            
            var final_color: Color = Color(0, 0, 0)
            
            for _ in 0..<camera.samples_per_pixel {
                let ray: Ray = camera.makeRay(i: i, j: j)
                scene.hit_record.reset()
                
                for object in scene.objects {
                    _ = object.hit(withRay: ray, recordWith: scene.hit_record)
                }
                
                if let object = scene.hit_record.object {
                    final_color +=  object.material.shade(object: object, atPoint: ray.getPoint(at: scene.hit_record.t), inScene: scene, withIncomingRay: ray)
                } else {
                    final_color += Color(1)
                }
            }
            
            final_color /= Color(Float(camera.samples_per_pixel))
            camera.film.setPixel(color: final_color, atX: i, y: j)
        }
    }
}
