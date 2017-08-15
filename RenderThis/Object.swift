//
//  Object.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

protocol Object {
    var material: Material { get set }
    func hit(withRay ray: Ray, recordWith hit_record: HitRecord) -> Bool
    func normal(atPoint point: Point) -> Normal
}
