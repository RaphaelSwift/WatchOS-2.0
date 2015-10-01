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
            item.accessoryImage = WKImage(imageName: "Success")
            item.contentImage = WKImage(image: drawColoredRect())
            item.caption = "caption" + "\(i)"
            pickerItems.append(item)
        }
        listPicker.setItems(pickerItems)
    }

    
    func drawColoredRect() -> UIImage {
        
        let rect = CGRectMake(0, 0, 600, 50)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.random.CGColor)
        CGContextFillRect(context, rect)
        let randomColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return randomColorImage
    }
}

extension UIColor {
    class var random: UIColor {
        switch arc4random() % 8 {
        case 0: return UIColor.blueColor()
        case 1: return UIColor.greenColor()
        case 2: return UIColor.purpleColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.yellowColor()
        case 5: return UIColor.orangeColor()
        case 6: return UIColor.cyanColor()
        case 7: return UIColor.lightGrayColor()
        default: return UIColor.magentaColor()
        }
    }
}
