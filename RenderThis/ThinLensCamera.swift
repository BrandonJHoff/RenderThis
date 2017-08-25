//
//  ThinLensCamera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/24/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class ThinLensCamera: Camera {
    let origin: Point
    var u: Vector
    var v: Vector
    let w: Vector
    let horizonal_dir: Vector
    let vertical_dir: Vector
    let lower_left_corner: Point
    let lens_radius: Float
    var film: Film
    var samples_per_pixel: Int
    
    init(origin: Point, look_at: Point, up: Vector, vertical_field_of_view vfov: Float, aperture: Float, focal_length: Float, film: Film, samples_per_pixel: Int) {
        self.origin = origin
        self.lens_radius = aperture / 2.0
        
        let theta = vfov * Float.pi / 180.0
        let half_canvas_height: Float = tan(theta * 0.5)
        let half_canvas_width: Float = half_canvas_height * (Float(film.horizontal_resolution) / Float(film.vertical_resolution))
        
        w = normalize(look_at - origin)
        u = normalize(cross(up, w))
        v = normalize(cross(w, u))
        
        lower_left_corner = origin - half_canvas_width * focal_length * u - half_canvas_height * focal_length * v + focal_length * w
        
        horizonal_dir = u * (2.0 * half_canvas_width * focal_length / Float(film.horizontal_resolution))
        vertical_dir = v * (2.0 * half_canvas_height * focal_length / Float(film.vertical_resolution))
        
        self.film = film
        self.samples_per_pixel = samples_per_pixel
    }
    
    func makeRay(i: Int, j: Int) -> Ray {
        let rd: Vector = randomOnDisk() * lens_radius
        let offset = u * rd.x + v * rd.y
        
        let x: Float = Float(i) + Float(drand48())
        let y: Float = Float(j) + Float(drand48())
        
        return Ray(origin: origin + offset, direction: lower_left_corner + x * horizonal_dir + y * vertical_dir - origin - offset)
    }

    func randomOnDisk() -> Vector {
        var p: Vector
        repeat {
            p = 2.0 * Vector(Float(drand48()), Float(drand48()), 0) - Vector(1, 1, 0)
        } while dot(p, p) > 1.0
        return p
    }
}
