//
//  SequentialAnimationInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 29.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class SequentialAnimationInterfaceController: WKInterfaceController {

    // Top-Level Groups
    @IBOutlet var topGroup: WKInterfaceGroup!
    @IBOutlet var middleGroup: WKInterfaceGroup!
    @IBOutlet var bottomGroup: WKInterfaceGroup!
    
    // Sub-Level Groups
    @IBOutlet var middleLeftGroup: WKInterfaceGroup!
    @IBOutlet var middleCenterGroup: WKInterfaceGroup!
    @IBOutlet var middleRightGroup: WKInterfaceGroup!

    // Square Groups
    
    @IBOutlet var group1: WKInterfaceGroup!
    @IBOutlet var group2: WKInterfaceGroup!
    @IBOutlet var group3: WKInterfaceGroup!
    @IBOutlet var group4: WKInterfaceGroup!
    @IBOutlet var group5: WKInterfaceGroup!
    @IBOutlet var group6: WKInterfaceGroup!
    @IBOutlet var group7: WKInterfaceGroup!
    @IBOutlet var group8: WKInterfaceGroup!
    @IBOutlet var group9: WKInterfaceGroup!
    @IBOutlet var group10: WKInterfaceGroup!
    @IBOutlet var group11: WKInterfaceGroup!
    @IBOutlet var group12: WKInterfaceGroup!
    
    
    var groups = [WKInterfaceGroup]()
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        groups = [group1,group2,group3,group4,group5,group6,group7,group8,group9,group10,group11,group12]
        
        for group in groups {
            group.setCornerRadius(8)
            group.setBackgroundColor(UIColor.redColor())
            group.setAlpha(0.3)
        }
    }
    
    override func didAppear() {
        super.didAppear()
        
        for (var i = 0; i < groups.count; i++) {
            let group = groups[i]
            
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC))
            
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.animateWithDuration(1) { () -> Void in
                    group.setAlpha(1.0)
                }
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
