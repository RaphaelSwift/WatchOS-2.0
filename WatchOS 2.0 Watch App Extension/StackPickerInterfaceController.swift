//
//  StackPickerInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 01.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation


class StackPickerInterfaceController: WKInterfaceController {

    @IBOutlet var stackPicker: WKInterfacePicker!
    
    var pickerItems = [WKPickerItem]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        stackPicker.setAlpha(0.0)
        stackPicker.setHeight(0)
        
        configurePicker()
    }
    
    override func didAppear() {
        animateWithDuration(2.0) { () -> Void in
            self.stackPicker.setAlpha(1.0)
            self.stackPicker.setHeight(100)
        }
    }

    
    func configurePicker() {
        pickerItems.removeAll()
        
        for _ in 1...10 {
            let item = WKPickerItem()
            item.contentImage = WKImage(image: UIImage.randomColoredRect())
            pickerItems.append(item)
        }
        stackPicker.setItems(pickerItems)
    }
}

private extension UIImage {
    static func randomColoredRect() -> UIImage {
        let rect = CGRectMake(0, 0, 800, 800)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.random.CGColor)
        CGContextFillRect(context, rect)
        let randomColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return randomColorImage
    }
}
