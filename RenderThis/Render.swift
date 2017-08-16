//
//  Render.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import Cocoa

func render() -> Film {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-1.5, 0.5, 10), radius: 1.2, material: LambertianMaterial(color: Color(1,0,0), kd: 0.7)))
    scene.add(object: Sphere(center: Point(0, 0, 10.1), radius: 1.7, material: LambertianMaterial(color: Color(0,1,0), kd: 0.7)))
    scene.add(object: Sphere(center: Point(1, -0.5, 10.2), radius: 1.9, material: LambertianMaterial(color: Color(0,0,1), kd: 0.7)))
    scene.add(object: Plane(origin: Point(0, -2, 0), normal: Normal(0, 1, 0), material: LambertianMaterial(color: Color(1,1,0), kd: 1)))
    scene.add(light: PointLight(position: Point(-30, 20, -80), color: Color(1,1,1)))
    //scene.add(light: DirectLight(direction: Vector(0,0,1), color: Color(1,1,1)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(0,0,-2), lookAt: Point(0,0,0), up: Vector(0,1,0), horizontal_field_of_view: 20, focal_length: 0.5, film: film)
    //let camera: OrthoCamera = OrthoCamera(position: Point(0, 0, -2), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), xSize: 5.0, ySize: 5.0, film: film)
    
    capture(scene: scene, withCamera: camera)
    
    return film
}
