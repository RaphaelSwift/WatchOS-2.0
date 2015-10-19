//
//  WikiFace.swift
//  WikiFace
//
//  Created by Raphael Neuenschwander on 19.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

// Download the image of a person from wikipedia and center it on its face using face recognition

import UIKit
import ImageIO

class WikiFace: NSObject {

    enum WikiFaceError: ErrorType {
        
        case CouldNotDownloadImage
    }
    
    class func faceForPerson (person: String, size: CGSize, completion: (image: UIImage?, imageFound: Bool) -> () )throws {
        let escapedString = person.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        let pixelsForAPIRequest = Int(max(size.width,size.height)) * 2
        
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&titles=\(escapedString!)&prop=pageimages&format=json&pithumbsize=\(pixelsForAPIRequest)"
        
        let url = NSURL(string: urlString)
        
        guard let task: NSURLSessionTask? = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if error == nil {
                let wikiDict = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(wikiDict)
                
                if let query = wikiDict.objectForKey("query") as? NSDictionary {
                    if let pages = query.objectForKey("pages") as? NSDictionary {
                        if let pageContent = pages.allValues.first as? NSDictionary {
                            if let thumbnail = pageContent.objectForKey("thumbnail") as? NSDictionary {
                                if let thumbURL = thumbnail.objectForKey("source") as? String {
                                    let faceImage = UIImage(data: NSData(contentsOfURL: NSURL(string: thumbURL)!)!)
                                        
                                    completion(image: faceImage, imageFound: true)
                                }

                            }
                            else {
                                completion(image: nil, imageFound: false)
                                }
                        }
                    }
                }
            }
        
        
        }) else {
            throw WikiFaceError.CouldNotDownloadImage
        }
        task!.resume()
    }
    
    
    class func centerImageViewOnFace (imageView: UIImageView) {
        let context = CIContext(options: nil)
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: options)
        
        let faceImage = imageView.image
        let ciImage = CIImage(CGImage: faceImage!.CGImage!)
        
        let features = detector.featuresInImage(ciImage)
        
        if features.count > 0 {
            
            var face: CIFaceFeature!
            
            for rect in features {
                face = rect as! CIFaceFeature
            }
            
            var faceRectWithExtendedBounds = face.bounds
            faceRectWithExtendedBounds.origin.x -= 20
            faceRectWithExtendedBounds.origin.y -= 30
            
            faceRectWithExtendedBounds.size.width += 40
            faceRectWithExtendedBounds.size.height += 60
            
            let x = faceRectWithExtendedBounds.origin.x / faceImage!.size.width
            let y = (faceImage!.size.height - faceRectWithExtendedBounds.origin.y - faceRectWithExtendedBounds.size.height) / faceImage!.size.height // different coordinate system between UIKit (0.0 at TOP left) & CoreGraphic (0.0 at BOTTOM left)
            
            let width = faceRectWithExtendedBounds.size.width / faceImage!.size.width
            let height = faceRectWithExtendedBounds.size.height / faceImage!.size.height
            
            imageView.layer.contentsRect = CGRectMake(x, y, width, height)
        }
    }
    
}
