//
//  Render.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import Cocoa
import GLKit

func render() -> Film {
    let scene: Scene = scene10()
    scene.buildStructure()
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
    scene.add(object: Sphere(center: Point(0, -102, 0), radius: 100, material: LambertianMaterial(color: Color(1, 1, 0))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: OrthoCamera = OrthoCamera(origin: Point(0, 0, -2), lookAt: Point(0, 0, 0), up: Vector(0, 1, 0), xSize: 5.0, ySize: 5.0, film: film, samples_per_pixel: 1)
    
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
    scene.add(object: Sphere(center: Point(0, -102, 0), radius: 100, material: LambertianMaterial(color: Color(1, 1, 0))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(0,0,-10), look_at: Point(0,0,0), up: Vector(0,1,0), vertical_field_of_view: 20, film: film, samples_per_pixel: 1)
    
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
    scene.add(object: Sphere(center: Point(0, -100, 0), radius: 100, material: LambertianMaterial(color: Color(1, 1, 0.7))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(0, 2.5, -20), look_at: Point(0, 2, 0), up: Vector(0, 1, 0), vertical_field_of_view: 25, film: film, samples_per_pixel: 1)

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
    scene.add(object: Sphere(center: Point(0, -100, 0), radius: 100, material: LambertianMaterial(color: Color(1, 0.3, 0.7))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(-2.5, 10, -20), look_at: Point(0, 3, 0), up: Vector(0, 1, 0), vertical_field_of_view: 25, film: film, samples_per_pixel: 1)
    
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
    let camera: PinholeCamera = PinholeCamera(origin: Point(0, 1, -4), look_at: Point(0, 0, 0), up: Vector(0, 1, 0), vertical_field_of_view: 22, film: film, samples_per_pixel: 1)
    
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
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(0, 1, -4), look_at: Point(0, 0, 0), up: Vector(0, 1, 0), vertical_field_of_view: 25, film: film, samples_per_pixel: 1)
    
    scene.add(camera: camera)
    
    return scene
}

func scene7() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(-1, 0, 1), radius: 0.5, material: DielectricMaterial(refractive_index: 1.5)))
    scene.add(object: Box(min: Point(-1, -0.1, 0.9), max: Point(0, 0.1, 1.1), material: LambertianMaterial(color: Color(1, 0.4, 1))))
    scene.add(object: Sphere(center: Point(1, 0, 1), radius: 0.5, material: MetalMaterial(color: Color(0.8, 0.6, 0.2), fuzz: 0)))
    scene.add(object: Sphere(center: Point(0, -100.5, 1), radius: 100, material: LambertianMaterial(color: Color(0.8, 0.8, 0))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(0, 1, -5), look_at: Point(0, 0, 0), up: Vector(0, 1, 0), vertical_field_of_view: 25, film: film, samples_per_pixel: 1)
    
    scene.add(camera: camera)
    
    return scene
}

func scene8() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    let metal1: Material = MetalMaterial(color: Color(0.8, 0.8, 0.8), fuzz: 0)
    let lamb1: Material = LambertianMaterial(color: Color(0.25, 0.95, 0.25))
    let lamb2: Material = LambertianMaterial(color: Color(0.6, 0.6, 0.9))
    let lamb3: Material = LambertianMaterial(color: Color(0.3, 0.3, 0.9))
    let lamb4: Material = LambertianMaterial(color: Color(0.9, 0.3, 0.3))
    
    scene.add(object: Sphere(center: Point(0, -97.5, 0), radius: 100, material: lamb1))
    
    for i in 0..<4 {
        let eta = 1.0 + Float(i) * 0.5 + 0.05
        let diel = DielectricMaterial(refractive_index: eta)
        let min_p = Point(Float(i) * 1.3 - 4, 2.5001, -3)
        let max_p = min_p + Point(0.20, 1.4, 2.5)
        scene.add(object: Box(min: min_p, max: max_p, material: diel))
    }
    
    for i in 0..<9 {
        let center: Point = Point(-6, 2.8, 0)
        let offset: Vector = Vector(0.675, 0, 0)
        scene.add(object: Ring(center: center + offset * Float(i), normal: Normal(0.2, -0.2, -1), min_radius: 0.15, max_radius: 0.3, material: lamb2))
    }
    
    scene.add(object: Sphere(center: Point(-5, 4.5, 4.5), radius: 1, material: metal1))
    scene.add(object: Sphere(center: Point(-6, 3.5, 3.5), radius: 1, material: metal1))
    scene.add(object: Sphere(center: Point(-7, 2.5, 2.5), radius: 1, material: metal1))
    
    for i in 0..<5 {
        scene.add(object: Sphere(center: Point(-4.5 + Float(i), 3 + (Float(i) / 2.0), 3.5 + (Float(i) / 4.0)), radius: 0.5, material: lamb3))
    }
    
    scene.add(object: Box(min: Point(-8.5, 2, -8.5), max: Point(-4.5, 8, -4.5), material: lamb4))
        
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: PinholeCamera = PinholeCamera(origin: Point(8.3, 7, -18), look_at: Point(-4.7, 3, 2.5), up: Vector(0, 1, 0), vertical_field_of_view: 15, film: film, samples_per_pixel: 1)
    
    scene.add(camera: camera)
    
    return scene
}

func scene9() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(0, 4, 4), radius: 2.5, material: LambertianMaterial(color: Color(0.1, 0.3, 0.9))))
    scene.add(object: Sphere(center: Point(2.5, 2, -2), radius: 2, material: LambertianMaterial(color: Color(1, 0.2, 0.2))))
    scene.add(object: Sphere(center: Point(-2, 1, -5), radius: 1, material: LambertianMaterial(color: Color(1, 0.9, 0.1))))
    scene.add(object: Sphere(center: Point(0, -100, 1), radius: 100, material: LambertianMaterial(color: Color(0.25, 0.95, 0.25))))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let camera: ThinLensCamera = ThinLensCamera(origin: Point(0, 5, -20), look_at: Point(0, 3, 0), up: Vector(0, 1, 0), vertical_field_of_view: 25, aperture: 2, focal_length: 24, film: film, samples_per_pixel: 1)
    
    scene.add(camera: camera)
    
    return scene
}

func scene10() -> Scene {
    let horizontal_resolution: Int = 640
    let vertical_resolution: Int = 480
    let scene: Scene = Scene()
    
    scene.add(object: Sphere(center: Point(0, -100, 0), radius: 100, material: LambertianMaterial(color: Color(0.5, 0.5, 0.5))))
    
    for i in -11..<11 {
        for j in -11..<11 {
            let choose_mat: Double = drand48()
            let center:Point = Point(Float(i) + 0.9 * Float(drand48()), 0.2, Float(j) + 0.9 * Float(drand48()))
            
            if length(center - Point(4, 0.2, 0)) > 0.9 {
                if choose_mat < 0.8 { // diffuse
                    scene.add(object: Sphere(center: center, radius: 0.2, material: LambertianMaterial(color: Color(Float(drand48()*drand48()), Float(drand48()*drand48()), Float(drand48()*drand48())))))
                } else if choose_mat < 0.95 { // metal
                    scene.add(object: Sphere(center: center, radius: 0.2, material: MetalMaterial(color: Color(Float(0.5 * (1.0 + drand48())), Float(0.5 * (1.0 + drand48())), Float(0.5 * (1.0 + drand48()))), fuzz: Float(0.5 * drand48()))))
                } else { // glass
                    scene.add(object: Sphere(center: center, radius: 0.2, material: DielectricMaterial(refractive_index: 1.5)))
                }
            }
        }
    }
    
    scene.add(object: Sphere(center: Point(0, 1, 0), radius: 1, material: DielectricMaterial(refractive_index: 1.5)))
    scene.add(object: Sphere(center: Point(-4, 1, 0), radius: 1, material: LambertianMaterial(color: Color(0.4, 0.2, 0.1))))
    scene.add(object: Sphere(center: Point(4, 1, 0), radius: 1, material: MetalMaterial(color: Color(0.7, 0.6, 0.5), fuzz: 0)))
    
    let film: Film = Film(horizontal_resolution: horizontal_resolution, vertical_resolution: vertical_resolution)
    let co = Point(15, 1, -3.5)
    let at = Point(3, 0.6, 0)
    let camera: ThinLensCamera = ThinLensCamera(origin: co, look_at: at, up: Vector(0, 1, 0), vertical_field_of_view: 17, aperture: 0.1, focal_length: length(co - at), film: film, samples_per_pixel: 1)
    
    scene.add(camera: camera)
    
    return scene
}


