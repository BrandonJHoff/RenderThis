//
//  PointLight.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class PointLight {
    var color: Color
    let position: Point
    
    init(position: Point, color: Color) {
        self.position = position
        self.color = color
    }
    
    func getLightInfo(withObjectPoint point: Point) -> (light_direction: Vector, light_color: Color) {
        return (normalize(position - point), color)
    }
}
