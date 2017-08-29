//
//  Scene.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/13/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

class Scene {
    var objects: [Object] = []
    var octree: Octree!
    var lights: [Light] = []
    var hit_record: HitRecord
    var camera: Camera!
    var bbox: BBox!
    
    init() {
        hit_record = HitRecord()
    }
    
    func add(object: Object) {
        Stats.total_objects += 1
        if bbox == nil {
            bbox = object.bbox
        } else {
            bbox = surroundBBox(b1: bbox, b2: object.bbox)
        }
        objects.append(object)
    }
    
    func add(light: Light) {
        lights.append(light)
    }
    
    func add(camera: Camera) {
        Stats.total_primary_rays = camera.film.horizontal_resolution * camera.film.vertical_resolution * camera.samples_per_pixel
        self.camera = camera
    }
    
    func buildStructure() {
        for i in 0..<objects.count {
            if octree == nil {
                octree = Octree(object: objects[i], bbox: bbox)
            } else {
                octree.insert(object: objects[i])
            }
        }
    }
}
