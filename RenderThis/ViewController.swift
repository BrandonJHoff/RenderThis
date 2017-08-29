//
//  ViewController.swift
//  RenderThis
//
//  Created by Brandon Hoff on 8/11/17.
//  Copyright © 2017 Brandon Hoff. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func renderPressed(_ sender: NSButton) {
        let startTime = CFAbsoluteTimeGetCurrent()
        let film = render()
        imageView.image = film.develop()
        
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed: \(timeElapsed) s.")
        print("Total number of objects: \(Stats.total_objects)")
        print("Total number of primary rays: \(Stats.total_primary_rays)")
        print("Total hit tests: \(Stats.total_hit_tests)")
        print("Total hits: \(Stats.total_hits)")
        print("Total bbox tests: \(Stats.total_bbox_tests)")
        print("Hit ratio: \(Float(Stats.total_hits) / Float(Stats.total_hit_tests))")
        print("Avg hit tests per ray: \(Stats.total_hit_tests / Stats.total_primary_rays)")
    }
}

