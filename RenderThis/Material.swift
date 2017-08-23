//
//  Material.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

protocol Material {
    func shade(object: Object, atPoint point: Point, inScene scene: Scene, withIncomingRay ray: Ray, atMaxDepth depth: Int) -> Color
}

func uniformSampleHemishpere() -> Vector {
    let r1: Float = Float(drand48())
    let r2: Float = Float(drand48())
    
    let sinTheta: Float = sqrtf(1 - r1 * r1);
    let phi: Float = Float(2.0) * Float.pi * r2;
    let x: Float = sinTheta * cosf(phi);
    let z: Float = sinTheta * sinf(phi);
    
    return Vector(x, r1, z);
}
