//
//  AnimatedImageInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 30.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class AnimatedImageInterfaceController: WKInterfaceController {

    @IBOutlet var animatedImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        animatedImage.setImageNamed("animation")
    }
    
    override func didAppear() {
        super.didAppear()
        
        animatedImage.startAnimatingWithImagesInRange(NSRange(location: 0, length: 90), duration: 3, repeatCount: 0)
    }
}
