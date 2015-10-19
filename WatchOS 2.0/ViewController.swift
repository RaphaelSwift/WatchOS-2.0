//
//  ViewController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITextFieldDelegate, WCSessionDelegate {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    @IBOutlet weak var faceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var session: WCSession? = {
        
        var lazyInitializedSession: WCSession?
        
        if WCSession.isSupported() {
            lazyInitializedSession = WCSession.defaultSession()
            lazyInitializedSession?.delegate = self
            lazyInitializedSession?.activateSession()
        }
        
        return lazyInitializedSession
    }()
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // dismiss keyboard
        
        if let textFieldContent = textField.text {
            do {
                try WikiFace.faceForPerson(textFieldContent, size: CGSize(width: 200, height: 200), completion: { (image: UIImage?, imageURL: String?, imageFound: Bool) -> () in
                    if imageFound == true {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.faceImageView.image = image
                            WikiFace.centerImageViewOnFace(self.faceImageView!)
                            
                            if self.sessionStateAvailable() {
                                let context = [
                                    "name": textFieldContent,
                                    "imageUrl": imageURL!
                                ]
                                self.transferApplicationContextToiWatch(context)
                            }
                        }
                    }
                })
            }
            catch WikiFace.WikiFaceError.CouldNotDownloadImage {
                print("Could not access wikipedia for downloading an image")
            }
            catch {
                print(error)
            }
        }
        return true
    }
    
    private func sessionStateAvailable() -> Bool {
        if let supportedSession = session {
            if supportedSession.paired && supportedSession.watchAppInstalled {
                return true
            }
        }
        return false
    }
    
    private func transferApplicationContextToiWatch (context: [String: AnyObject]) {
        do {
            try session?.updateApplicationContext(context)
        } catch {
            print(error)
        }
    }
}


