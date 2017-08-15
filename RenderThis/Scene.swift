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
    
    init() {
        hit_record = HitRecord()
    }
    
    func add(object: Object) {
        objects.append(object)
    }
    
    func add(light: Light) {
        lights.append(light)
    }
}
