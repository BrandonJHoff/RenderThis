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
    let position: Point
    let u: Vector
    let v: Vector
    let w: Vector
    let x_scale: Float
    let y_scale: Float
    var film: Film
    
    init(position: Point, lookAt: Point, up: Vector, horizontal_field_of_view hfov: Float, focal_length: Float, film: Film) {
        self.position = position
        self.film = film
        let image_width: Float = 2.0 * tan(hfov * 0.5) * focal_length
        let image_height: Float = image_width / (Float(film.horizontal_resolution) / Float(film.vertical_resolution))
        w = normalize(lookAt - position)
        u = normalize(cross(up, w)) * image_width
        v = normalize(cross(w, u)) * image_height
        x_scale = 2.0 / Float(film.horizontal_resolution)
        y_scale = 2.0 / Float(film.vertical_resolution)
    }
    
    func makeRay(i: Int, j: Int) -> Ray {
        let x: Float = (Float(i) + 0.5) * x_scale - 1
        let y: Float = (Float(j) + 0.5) * y_scale - 1
        let dir: Vector = normalize(w + x * u + y * v)
        return Ray(origin: position, direction: dir)
    }
}
