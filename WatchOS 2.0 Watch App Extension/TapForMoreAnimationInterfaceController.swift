//
//  TapForMoreAnimationInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class TapForMoreAnimationInterfaceController: WKInterfaceController {

    @IBOutlet var descriptionTable: WKInterfaceTable!


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        descriptionTable.setNumberOfRows(1, withRowType: "DescriptionRow")
        
        if let rc = descriptionTable.rowControllerAtIndex(0) as? TapForMoreDescriptionRow {
            rc.shortDescriptionLabel.setText("This text is too long to be displayed entirely... ")
            rc.fullDescriptionLabel.setText("This text can be displayed entirely, so we can say a lot more things and it doesn't matter because the user want to see everything")
            rc.fullDescriptionLabel.setHidden(true)
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        if let rc = table.rowControllerAtIndex(0) as? TapForMoreDescriptionRow {
            rc.shortDescriptionLabel.setHidden(true)
            rc.moreLabel.setHidden(true)
            rc.fullDescriptionLabel.setHidden(false)
            
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
