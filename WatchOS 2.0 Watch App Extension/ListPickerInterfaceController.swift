//
//  ListPickerInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 01.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class ListPickerInterfaceController: WKInterfaceController {

    @IBOutlet var listPicker: WKInterfacePicker!
    @IBOutlet var selectedItemLabel: WKInterfaceLabel!
    
    var pickerItems  = [WKPickerItem]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        configurePicker()
        selectedItemLabel.setText(pickerItems[0].title ?? "label")
    }

    @IBAction func pickItem(value: Int) {
        let title = pickerItems[value].title ?? ""
        selectedItemLabel.setText(title)
    }
    
    
    func configurePicker() {
        pickerItems.removeAll()
        
        for i in 1...10 {
            let item = WKPickerItem()
            item.title = "item" + "\(i)"
            item.accessoryImage = WKImage(image: UIImage(named: "Success")!)
            item.caption = "caption" + "\(i)"
            pickerItems.append(item)
        }
        listPicker.setItems(pickerItems)
    }


}
