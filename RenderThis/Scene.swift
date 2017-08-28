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
    var lights: [Light] = []
    var hit_record: HitRecord
    var camera: Camera!
    
    init() {
        hit_record = HitRecord()
    }
    
    func add(object: Object) {
        Stats.total_objects += 1
        objects.append(object)
    }
    
    func add(light: Light) {
        lights.append(light)
    }
    
    func add(camera: Camera) {
        Stats.total_primary_rays = camera.film.horizontal_resolution * camera.film.vertical_resolution * camera.samples_per_pixel
        self.camera = camera
    }
}
