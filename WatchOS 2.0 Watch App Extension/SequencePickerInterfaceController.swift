//
//  SequencePickerInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 01.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class SequencePickerInterfaceController: WKInterfaceController {

    @IBOutlet var sequencePicker: WKInterfacePicker!
    
    @IBOutlet var progressInterfaceGroup: WKInterfaceGroup!
    
    var pickerItems = [WKPickerItem]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        configurePicker()
    }
    
    func configurePicker() {
        pickerItems.removeAll()
        
        for i in 0...100 {
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: "RedCircle\(i)")
            pickerItems.append(item)
        }
        sequencePicker.setItems(pickerItems)
    }
}

