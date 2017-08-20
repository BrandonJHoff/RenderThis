//
//  OrthoCamera.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/12/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class OrthoCamera: Camera {
    let position: Point
    let u: Vector
    let v: Vector
    let w: Vector
    let x_scale: Float
    let y_scale: Float
    var film: Film
    var samples_per_pixel: Int
    
    init(position: Point, lookAt: Point, up: Vector, xSize: Float, ySize: Float, film: Film, samples_per_pixel: Int) {
        self.position = position
        self.film = film
        self.samples_per_pixel = samples_per_pixel
        w = normalize(lookAt - position)
        u = normalize(cross(up, w)) * xSize
        v = normalize(cross(w, u)) * ySize
        x_scale = 2.0 / Float(film.horizontal_resolution)
        y_scale = 2.0 / Float(film.vertical_resolution)
    }
    
    func makeRay(i: Int, j: Int) -> Ray {
        let x: Float = (Float(i) + 0.5) * x_scale - 1
        let y: Float = (Float(j) + 0.5) * y_scale - 1
        let p: Point = position + x * u + y * v
        return Ray(origin: p, direction: w)
    }
}
