//
//  Camera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

protocol Camera {
    var film: Film { get set }
    func makeRay(x: Float, y: Float) -> Ray
}

func capture(scene: Scene, withCamera camera: Camera) {
    let half_width: Float = Float(camera.film.width / 2) + 0.5
    let half_height: Float = Float(camera.film.height / 2) + 0.5
    
    
    for i in 0..<camera.film.width {
        for j in 0..<camera.film.height {
            let x: Float = 2.0 * (Float(i) - half_width) / Float(camera.film.width)
            let y: Float = 2.0 * (Float(j) - half_height) / Float(camera.film.height)
            
            let ray: Ray = camera.makeRay(x: x, y: y)
            scene.hit_record.reset()
            
            for object in scene.objects {
                object.hit(withRay: ray, recordWith: scene.hit_record)
            }
            
            if let object = scene.hit_record.object {
                camera.film.setPixel(color: object.material.shade(object: object, atPoint: ray.getPoint(at: scene.hit_record.t), inScene: scene, withIncomingRay: ray), atX: i, y: j)
            }
        }
    }
}
