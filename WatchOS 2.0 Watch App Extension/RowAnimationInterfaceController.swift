//
//  RowAnimationInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class RowAnimationInterfaceController: WKInterfaceController {

    @IBOutlet var imageNearMe: WKInterfaceImage!
    @IBOutlet var spacerGroup: WKInterfaceGroup!

    @IBOutlet var textLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        imageNearMe.setAlpha(0.0)
        textLabel.setAlpha(0.0)
        imageNearMe.setImage(UIImage(named: "Near Me Filled"))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didAppear() {
        super.didAppear()
        // Set the width of the spacer group to 0, which will make this group disappear and affect the label layout (comes from the right)
        animateWithDuration(0.3) { () -> Void in
            self.imageNearMe.setAlpha(1.0)
            self.textLabel.setAlpha(1.0)
            self.spacerGroup.setWidth(0.0)
        }
    }


    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
