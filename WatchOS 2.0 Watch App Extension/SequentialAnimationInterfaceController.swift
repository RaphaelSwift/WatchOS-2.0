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

    // Outer Groups (Circles)
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
    
    // Label
    @IBOutlet var counterLabel: WKInterfaceLabel!
    
    var counter = Int.random(12)
    
    private var outerGroups = [WKInterfaceGroup]()
    
    //MARK: - Constants
    
    private struct Constants {
        static let groupColor = UIColor.redColor()
        static let delay: Double = 0.06 // in seconds
    }
    
    
    //MARK: - LifeCycle
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        outerGroups = [group1,group2,group3,group4,group5,group6,group7,group8,group9,group10,group11,group12]
        
        for group in outerGroups {
            group.setCornerRadius(10)
            group.setBackgroundColor(Constants.groupColor)
            group.setAlpha(0.0)
        }
        
    }
    
    override func didAppear() {
        super.didAppear()
        
        for (var i = 0; i < outerGroups.count; i++) {
            let group = outerGroups[i]
            
            let delay = Double(i) * Constants.delay * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            let alpha: CGFloat = (i < counter) ? 1.0 : 0.3
            let counterNumber: Int = (i + 1 < counter) ? i : counter
            
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                self.animateWithDuration(0.3) { () -> Void in
                    group.setAlpha(alpha)
                    self.counterLabel.setText("\(counterNumber)")
                }
            }
        }
    }
}

// return a random number between 1 to max
private extension Int {
    static func random(max:Int) -> Int{
        return Int(arc4random() % UInt32(max) + 1)
    }
}
