//
//  CoordinationPickerInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 02.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class CoordinationPickerInterfaceController: WKInterfaceController {

    @IBOutlet var progressInterfaceGroup: WKInterfaceGroup!
    @IBOutlet var coordinationPicker: WKInterfacePicker!
    
    var pickerItems = [WKPickerItem]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        if let progressImages = UIImage.animatedImageNamed("RedCircle", duration: 0.0) {
            progressInterfaceGroup.setBackgroundImage(progressImages)
        }
        
        configurePicker()
        
        coordinationPicker.setCoordinatedAnimations([progressInterfaceGroup])
        
    }
    
    func configurePicker() {
        pickerItems.removeAll()
        
        for i in 0...100 {
            let item = WKPickerItem()
            item.title = "\(i) %"
            pickerItems.append(item)
        }
        coordinationPicker.setItems(pickerItems)
    }
    

}
