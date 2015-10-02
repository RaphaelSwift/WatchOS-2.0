//
//  Event.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 02.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import Foundation


class Event {
    
    var matches: [Match] {
        
        var createdMatched = [Match]()
        for i in 0...10 {
            createdMatched.append(Match(time: NSDate(timeIntervalSinceNow: Double(60 * 60 * i)), playerOne: randomPlayer(), playerTwo: randomPlayer()))
        }
        
        return createdMatched
    }
    
    struct Match {
        var time: NSDate
        var playerOne: String
        var playerTwo: String
    }
    
    
    func firstMatch() -> Match {
        return matches.first!
    }
    
    func lastMatch() -> Match  {
        return matches.last!
    }
    
    func randomPlayer () -> String {
        
        switch arc4random() % 8 {
        case 0: return ("Federer")
        case 1: return ("Wawrinka")
        case 2: return ("Djokovic")
        case 3: return ("Nadal")
        case 4: return ("Murray")
        case 5: return ("Haas")
        case 6: return ("Soderling")
        case 7: return ("Yoshi")
        default: return ("Hyade")
        }
        
        
    }
}
