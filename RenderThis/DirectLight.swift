//
//  DirectLight.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class DirectLight {
    var color: Color
    let direction: Vector
    
    init(direction: Vector, color: Color) {
        self.direction = normalize(direction)
        self.color = color
    }
    
    func getLightInfo(withObjectPoint point: Point) -> (light_direction: Vector, light_color: Color) {
        return (-direction, color)
    }
}
