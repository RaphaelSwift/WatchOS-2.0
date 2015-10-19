//
//  ApplicationContextInterfaceController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 19.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class ApplicationContextInterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var faceImage: WKInterfaceImage!
    @IBOutlet var personNameLabel: WKInterfaceLabel!
    
    
    var session = WCSession.defaultSession()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        session.delegate = self
        print("delegate Set")
        session.activateSession()
        print("sesions activated")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        if let name = applicationContext["name"] as? String {
            personNameLabel.setText(name)
        }
        
        if let imageURL = applicationContext["imageUrl"] as? String {
            fetchAndDisplayImage(imageURL)
        }
    }
    
    private func fetchAndDisplayImage(imageUrl: String) {
        
        // good place to start an activity indicator
        
        let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
        
        //fetch the data off the main queue
        dispatch_async(dispatch_get_global_queue(qos, 0)) {
            if let url = NSURL(string: imageUrl), let data = NSData(contentsOfURL: url), let image = UIImage(data: data) {
                //update the UI on the main queue
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.faceImage.setImage(image)
                    // good place to stop an activity indicator
                }
            } else {
                // good place to stop an activity indicator
            }
            
        }
    }
}
