//
//  Object.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/14/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation

protocol Object {
    func hit(withRay ray: Ray) -> Bool
}
