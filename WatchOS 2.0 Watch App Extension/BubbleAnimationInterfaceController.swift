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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        textBubble.setText("This is the text displayed in the text bubble")
        textBubble.setWidth(0)
        textBubble.setAlpha(0.0)
        
        confirmationButton.setAlpha(0.0)
    }
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didAppear() {
        super.didAppear()
        
        animateWithDuration(0.3) { () -> Void in
            self.textBubble.setRelativeWidth(1.0, withAdjustment: 0)
            self.textBubble.sizeToFitHeight()
            self.textBubble.setAlpha(1.0)
            
            self.confirmationButton.setAlpha(1.0)
            
            self.textContainer.sizeToFitHeight()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
