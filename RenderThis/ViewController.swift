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
        print("Time elapsed): \(timeElapsed) s.")
    }
}

