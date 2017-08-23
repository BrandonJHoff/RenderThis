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
    let scene: Scene = scene6()
    capture(scene: scene, withCamera: scene.camera)
    return scene.camera.film
}

func scene1() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-1.5, 0.5, 10), radius: 1.2, material: LambertianMaterial(color: Color(1,0,0))))
    scene.add(object: Sphere(center: Point(0, 0, 10.1), radius: 1.7, material: LambertianMaterial(color: Color(0,1,0))))
    scene.add(object: Sphere(center: Point(1, -0.5, 10.2), radius: 1.9, material: LambertianMaterial(color: Color(0,0,1))))
    scene.add(object: Plane(origin: Point(0, -2, 0), normal: Normal(0, 1, 0), material: LambertianMaterial(color: Color(1,1,0))))
    scene.add(light: PointLight(position: Point(-30, 20, -80), color: Color(1,1,1)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: OrthoCamera = OrthoCamera(position: Point(0, 0, -2), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), xSize: 5.0, ySize: 5.0, film: film, samples_per_pixel: 4)
    
    scene.add(camera: camera)
    
    return scene
}

func scene2() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-1.5, 0.5, 10), radius: 1.2, material: LambertianMaterial(color: Color(1,0,0))))
    scene.add(object: Sphere(center: Point(0, 0, 10.1), radius: 1.7, material: LambertianMaterial(color: Color(0,1,0))))
    scene.add(object: Sphere(center: Point(1, -0.5, 10.2), radius: 1.9, material: LambertianMaterial(color: Color(0,0,1))))
    scene.add(object: Plane(origin: Point(0, -2, 0), normal: Normal(0, 1, 0), material: LambertianMaterial(color: Color(1,1,0))))
    scene.add(light: PointLight(position: Point(-30, 20, -80), color: Color(1,1,1)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(0,0,-10), lookAt: Point(1,2.4,1), up: Vector(0,1,0), horizontal_field_of_view: 20, focal_length: 0.5, film: film, samples_per_pixel: 4)
    
    scene.add(camera: camera)
    
    return scene
}


func scene3() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-4, 3.5, 1.5), radius: 2, material: LambertianMaterial(color: Color(0.1, 0.3, 0.9))))
    scene.add(object: Sphere(center: Point(0, 1, 0.5), radius: 1, material: LambertianMaterial(color: Color(1, 0.9, 0.1))))
    scene.add(object: Sphere(center: Point(2, 1.5, -0.5), radius: 1.5, material: LambertianMaterial(color: Color(1, 0.2, 0.2))))
    scene.add(object: Plane(origin: Point(0, 0, 0), normal: Normal(0, 1, 0), material: LambertianMaterial(color: Color(1, 1, 0.7))))
    
    scene.add(light: PointLight(position: Point(20, 80, -30), color: Color(1, 1, 1)))
    scene.add(light: PointLight(position: Point(50, 40, -20), color: Color(1, 1, 1)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(0, 2.5, -10), lookAt: Point(0, 2, 0), up: Vector(0, 1, 0), horizontal_field_of_view: 20, focal_length: 0.5, film: film, samples_per_pixel: 4)

    scene.add(camera: camera)
    
    return scene
}

func scene4() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    let disk_material_1 = LambertianMaterial(color: Color(1, 0.2, 0.2))
    let disk_material_2 = LambertianMaterial(color: Color(0.2, 1, 0.2))
    let ring_material = LambertianMaterial(color: Color(0.25, 0.25, 1))
    
    scene.add(object: Box(min: Point(-4.5, 0, -4.5), max: Point(4.5, 2, 4.5), material: LambertianMaterial(color: Color(0.8, 0.8, 0.8))))
    scene.add(object: Box(min: Point(-3.5, 2, -3.5), max: Point(0, 2.75, 0), material: LambertianMaterial(color: Color(1, 0.4, 1))))
    scene.add(object: Triangle(p0: Point(1, 3, 1), p1: Point(3, 2, -0.5), p2: Point(3, 5, 1.5), material: LambertianMaterial(color: Color(1, 1, 0))))
    scene.add(object: Disk(center: Point(3, 2.5, -3.3), normal: Normal(-1, 1, -1), radius: 0.5, material: disk_material_1))
    scene.add(object: Disk(center: Point(2.5, 2.5, -3.3), normal: Normal(-1, 1, -1), radius: 0.5, material: disk_material_2))
    scene.add(object: Disk(center: Point(2, 2.5, -3.3), normal: Normal(-1, 1, -1), radius: 0.5, material: disk_material_1))
    scene.add(object: Disk(center: Point(1.5, 2.5, -3.3), normal: Normal(-1, 1, -1), radius: 0.5, material: disk_material_2))
    scene.add(object: Disk(center: Point(1, 2.5, -3.3), normal: Normal(-1, 1, -1), radius: 0.5, material: disk_material_1))
    scene.add(object: Sphere(center: Point(-2, 5, 2), radius: 0.8, material: LambertianMaterial(color: Color(1, 0, 0))))
    scene.add(object: Ring(center: Point(-2, 5, 2), normal: Normal(1, 1, -1), min_radius: 1.2, max_radius: 1.8, material: ring_material))
    scene.add(object: Ring(center: Point(-2, 5, 2), normal: Normal(1, 1, -1), min_radius: 2.2, max_radius: 2.8, material: ring_material))
    scene.add(object: Plane(origin: Point(0, 0, 0), normal: Normal(0, 1, 0), material: LambertianMaterial(color: Color(1, 0.3, 0.7))))
    
    scene.add(light: PointLight(position: Point(-40, 100, -40), color: Color(1, 1, 1)))
    scene.add(light: PointLight(position: Point(20, 100, -40), color: Color(1, 1, 1)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(-2.5, 10, -20), lookAt: Point(0, 3, 0), up: Vector(0, 1, 0), horizontal_field_of_view: 90, focal_length: 0.1, film: film, samples_per_pixel: 4)
    
    scene.add(camera: camera)
    
    return scene
}


func scene5() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(0, 0, 1), radius: 0.5, material: LambertianMaterial(color: Color(0.8, 0.8, 0.8))))
    scene.add(object: Sphere(center: Point(0, -100.5, 1), radius: 100, material: LambertianMaterial(color: Color(1, 0.5, 0.5))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(0, 1, -4), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), horizontal_field_of_view: 90, focal_length: 0.1, film: film, samples_per_pixel: 32)
    
    scene.add(camera: camera)
    
    return scene
}

func scene6() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-1, 0, 1), radius: 0.5, material: MetalMaterial(color: Color(0.8, 0.8, 0.8), fuzz: 0.3)))
    scene.add(object: Sphere(center: Point(0, 0, 1), radius: 0.5, material: LambertianMaterial(color: Color(0.8, 0.3, 0.3))))
    scene.add(object: Sphere(center: Point(1, 0, 1), radius: 0.5, material: MetalMaterial(color: Color(0.8, 0.6, 0.2), fuzz: 0)))
    scene.add(object: Sphere(center: Point(0, -100.5, 1), radius: 100, material: LambertianMaterial(color: Color(0.8, 0.8, 0))))
    //scene.add(object: Sphere(center: Point(0, 0, 0), radius: -1000, material: LambertianMaterial(color: Color(1, 1, 1))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(position: Point(0, 1, -4), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), horizontal_field_of_view: 90, focal_length: 0.1, film: film, samples_per_pixel: 10)
    
    scene.add(camera: camera)
    
    return scene
}

