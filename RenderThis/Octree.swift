//
//  Octree.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/28/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Foundation
import GLKit

class Octree {
    var children: [Octree?]
    var data: [Object] = []
    let tree_bbox: BBox
    var object_bbox: BBox
    var leaf_node: Bool
    
    init(object: Object, min: Point, max: Point) {
        self.children = Array(repeating: nil, count: 8)
        self.data.append(object)
        self.tree_bbox = BBox(min: min, max: max)
        self.object_bbox = object.bbox
        self.leaf_node = true
    }
    
    init(object: Object, bbox: BBox) {
        self.children = Array(repeating: nil, count: 8)
        self.data.append(object)
        self.tree_bbox = bbox
        self.object_bbox = object.bbox
        self.leaf_node = true
    }
    
    func insert(object: Object) {
        self.object_bbox = surroundBBox(b1: self.object_bbox, b2: object.bbox)

        if self.leaf_node && self.data.count < 5 {
            self.data.append(object)
        } else {
            insert(object: object, at_index: getChildIndex(object: object))
            for i in 0..<self.data.count {
                insert(object: self.data[i], at_index: getChildIndex(object: self.data[i]))
            }
            self.data.removeAll()
            self.leaf_node = false
        }
    }
    
    func insert(object: Object, at_index index: Int) {
        if children[index] == nil {
            let child_bbox = getChildBBox(index: index)
            children[index] = Octree(object: object, bbox: child_bbox)
        } else {
            children[index]?.insert(object: object)
        }
    }
    
    func getChildIndex(object: Object) -> Int {
        var index: Int = object.bbox.center.x < self.tree_bbox.center.x ? 0 : 4
        index += object.bbox.center.y < self.tree_bbox.center.y ? 0 : 2
        index += object.bbox.center.z < self.tree_bbox.center.z ? 0 : 1
        return index
    }
    
    func getChildBBox(index: Int) -> BBox {
        switch index {
            case 0 :
                return BBox(min: self.tree_bbox.min, max: self.tree_bbox.center)
            case 1 :
                return BBox(min: Point(self.tree_bbox.min.x, self.tree_bbox.min.y, self.tree_bbox.center.z), max: Point(self.tree_bbox.center.x, self.tree_bbox.center.y, self.tree_bbox.max.z))
            case 2:
                return BBox(min: Point(self.tree_bbox.min.x, self.tree_bbox.center.y, self.tree_bbox.min.z), max: Point(self.tree_bbox.center.x, self.tree_bbox.max.y, self.tree_bbox.center.z))
            case 3:
                return BBox(min: Point(self.tree_bbox.min.x, self.tree_bbox.center.y, self.tree_bbox.center.z), max: Point(self.tree_bbox.center.x, self.tree_bbox.max.y, self.tree_bbox.max.z))
            case 4:
                return BBox(min: Point(self.tree_bbox.center.x, self.tree_bbox.min.y, self.tree_bbox.min.z), max: Point(self.tree_bbox.max.x, self.tree_bbox.center.y, self.tree_bbox.center.z))
            case 5:
                return BBox(min: Point(self.tree_bbox.center.x, self.tree_bbox.min.y, self.tree_bbox.center.z), max: Point(self.tree_bbox.max.x, self.tree_bbox.center.y, self.tree_bbox.max.z))
            case 6:
                return BBox(min: Point(self.tree_bbox.center.x, self.tree_bbox.center.y, self.tree_bbox.min.z), max: Point(self.tree_bbox.max.x, self.tree_bbox.max.y, self.tree_bbox.center.z))
            case 7:
                return BBox(min: self.tree_bbox.center, max: self.tree_bbox.max)
            default:
                return BBox(min: Point(0), max: Point(0))
        }
    }
    
    func intersect(withRay ray: Ray, recordWith hit_record: HitRecord) {
        if self.object_bbox.hit(withRay: ray, recordWith: hit_record) {
            if self.leaf_node {
                for i in 0..<self.data.count {
                    _ = self.data[i].hit(withRay: ray, recordWith: hit_record)
                }
            } else {
                for i in 0..<children.count {
                    if children[i] != nil {
                        children[i]?.intersect(withRay: ray, recordWith: hit_record)
                    }
                }
            }
        }
    }
}
