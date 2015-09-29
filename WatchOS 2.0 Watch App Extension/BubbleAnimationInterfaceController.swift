//
//  BubbleAnimationInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class BubbleAnimationInterfaceController: WKInterfaceController {

    @IBOutlet var textBubble: WKInterfaceLabel!
    @IBOutlet var confirmationButton: WKInterfaceButton!
    @IBOutlet var textContainer: WKInterfaceGroup!
    
    @IBOutlet var confirmationContainer: WKInterfaceGroup!
    @IBOutlet var bubble: WKInterfaceGroup!
    
    @IBOutlet var successInterfaceImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        bubble.setAlpha(0.0)
        bubble.setCornerRadius(15)
        bubble.setBackgroundColor(UIColor.blueColor())
        bubble.setContentInset(UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
        
        bubble.setWidth(0)
        
        textBubble.setText("This is the text displayed in the text bubble")
        
        textContainer.setRelativeHeight(1.0, withAdjustment: 0)
        
        confirmationButton.setAlpha(0.0)
        
        confirmationContainer.setHeight(0)
        confirmationContainer.setAlpha(0.0)
        
        successInterfaceImage.setImage(UIImage(named: "Success"))
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didAppear() {
        super.didAppear()
        
        animateWithDuration(0.5) { () -> Void in
            
            self.bubble.setRelativeWidth(1.0, withAdjustment: 0) // causes the bubble to expand horizontally
            self.bubble.sizeToFitHeight() // size of the bubble to fit the content's height
            self.bubble.setAlpha(1.0) // fades in
            
            self.confirmationButton.setAlpha(1.0) // fades in
            
            // causes the text bubble and confirmation button to move upward
            self.textContainer.sizeToFitHeight()
        }
    }

    @IBAction func confirm() {
        animateWithDuration(0.5) { () -> Void in
            self.textContainer.setHeight(0)
            self.confirmationContainer.setAlpha(1.0)
            self.confirmationContainer.setRelativeHeight(1.0, withAdjustment: 0)
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
