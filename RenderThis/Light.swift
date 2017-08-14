//
//  Light.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

protocol Light {
    var color: Color { get set }
    func getLightInfo(withObjectPoint point: Point) -> (light_direction: Vector, light_color: Color)
}
