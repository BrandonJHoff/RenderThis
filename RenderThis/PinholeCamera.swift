//
//  PinholeCamera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class PinholeCamera: Camera {
    let origin: Point
    var u: Vector
    var v: Vector
    let w: Vector
    let lower_left_corner: Point
    var film: Film
    var samples_per_pixel: Int
    
    init(origin: Point, look_at: Point, up: Vector, vertical_field_of_view vfov: Float, film: Film, samples_per_pixel: Int) {
        self.origin = origin
        
        let theta = vfov * Float.pi / 180.0
        let half_canvas_height: Float = tan(theta * 0.5)
        let half_canvas_width: Float = half_canvas_height * (Float(film.horizontal_resolution) / Float(film.vertical_resolution))
        
        w = normalize(look_at - origin)
        u = normalize(cross(up, w))
        v = normalize(cross(w, u))
        
        lower_left_corner = origin - half_canvas_width * u - half_canvas_height * v + w
        
        u *= 2.0 * half_canvas_width / Float(film.horizontal_resolution)
        v *= 2.0 * half_canvas_height / Float(film.vertical_resolution)
        
        self.film = film
        self.samples_per_pixel = samples_per_pixel
    }
    
    func makeRay(i: Int, j: Int) -> Ray {
        let x: Float = Float(i) + Float(drand48())
        let y: Float = Float(j) + Float(drand48())
        let dir: Vector = lower_left_corner + x * u + y * v - origin
        return Ray(origin: origin, direction: dir)
    }
}
