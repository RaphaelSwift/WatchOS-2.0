//
//  ViewController.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, UITextFieldDelegate {
    
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // dismiss keyboard
        
        if let textFieldContent = textField.text {
            do {
                try WikiFace.faceForPerson(textFieldContent, size: CGSize(width: 200, height: 200), completion: { (image: UIImage?, imageFound: Bool) -> () in
                    if imageFound == true {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.faceImageView.image = image
                            WikiFace.centerImageViewOnFace(self.faceImageView!)
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
    
}


