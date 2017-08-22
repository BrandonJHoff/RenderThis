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
