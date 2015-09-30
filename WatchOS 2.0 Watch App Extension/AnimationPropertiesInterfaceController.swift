//
//  AnimationPropertiesInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 30.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class AnimationPropertiesInterfaceController: WKInterfaceController {

    
    @IBOutlet var outerGroup: WKInterfaceGroup!
    @IBOutlet var innerGroup: WKInterfaceGroup!
    @IBOutlet var animationLabel: WKInterfaceLabel!
    
    var timer = NSTimer()
    
    override func didAppear() {
        super.didAppear()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: "animationLoop", userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func animationLoop() {
        let _ = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: "animateColor", userInfo: nil, repeats: false)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "animateAlignement", userInfo: nil, repeats: false)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "animateOpacity", userInfo: nil, repeats: false)
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: "animateBackToOriginalStatus", userInfo: nil, repeats: false)
    }
    
    
    override func didDeactivate() {
        super.didDeactivate()
        timer.invalidate()
    }
    
    func animateColor() {
        animateWithDuration(2.0) { () -> Void in
            self.innerGroup.setBackgroundColor(UIColor.blackColor())
            self.outerGroup.setBackgroundColor(UIColor.greenColor())
            self.animationLabel.setText("Color")
        }
    }
    
    func animateAlignement() {
        animateWithDuration(2.0) { () -> Void in
            self.outerGroup.setHorizontalAlignment(.Left)
            self.outerGroup.setVerticalAlignment(.Bottom)
            self.innerGroup.setRelativeHeight(0.75, withAdjustment: 0)
            self.innerGroup.setRelativeWidth(0.75, withAdjustment: 0)
            self.animationLabel.setText("Alignement")
        }
    }
    
    func animateOpacity() {
        animateWithDuration(2.0) { () -> Void in
            self.innerGroup.setAlpha(0.3)
            self.outerGroup.setAlpha(1.0)
            self.animationLabel.setText("Opacity")
        }
    }
    
    func animateBackToOriginalStatus() {
        animateWithDuration(2.0) { () -> Void in
            self.innerGroup.setBackgroundColor(UIColor.redColor())
            self.innerGroup.setRelativeHeight(0.5, withAdjustment: 0)
            self.innerGroup.setRelativeWidth(0.5, withAdjustment: 0)
            self.innerGroup.setAlpha(1)
            
            self.outerGroup.setHorizontalAlignment(.Center)
            self.outerGroup.setVerticalAlignment(.Center)
            self.outerGroup.setBackgroundColor(UIColor.blueColor())
            self.outerGroup.setAlpha(0.5)
            self.animationLabel.setText("Mixed")
        }
    }
}
