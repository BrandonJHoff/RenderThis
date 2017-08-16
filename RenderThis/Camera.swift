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
    func makeRay(i: Int, j: Int) -> Ray
}

func capture(scene: Scene, withCamera camera: Camera) {
    for i in 0..<camera.film.horizontal_resolution {
        for j in 0..<camera.film.vertical_resolution {
            let ray: Ray = camera.makeRay(i: i, j: j)
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
