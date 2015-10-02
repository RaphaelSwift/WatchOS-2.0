//
//  Event.swift
//  WatchOS 2.0
//
//  Created by Raphael Neuenschwander on 02.10.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import Foundation


class TennisMatch {
    
    var matches: [Match] {
        
        var createdMatched = [Match]()
        for i in 0...10 {
            createdMatched.append(Match(time: NSDate(timeIntervalSinceNow: Double(60 * 60 * i)), playerOne: randomPlayer(), playerTwo: randomPlayer(), index: i))
        }
        
        return createdMatched
    }
    
    func firstMatch() -> Match {
        return matches.first!
    }
    
    func lastMatch() -> Match  {
        return matches.last!
    }
    
    func previousMatch(match:Match) -> Match? {
        if match.index - 1 >= 0 {
            return matches[match.index - 1]
        }
        return nil
    }
    
    func nextMatch(match:Match) -> Match? {
        if match.index + 1 < matches.count {
            return matches[match.index + 1]
        }
        return nil
    }
    
    func randomPlayer () -> String {
        
        switch arc4random() % 8 {
        case 0: return ("Federer")
        case 1: return ("Wawrinka")
        case 2: return ("Djokovic")
        case 3: return ("Nadal")
        case 4: return ("Murray")
        case 5: return ("Berdych")
        case 6: return ("Nishikori")
        case 7: return ("Ferrer")
        default: return ("Gasquet")
        }
    }
    
    class func sharedInstance() -> TennisMatch {
        struct Singleton {
            static var sharedInstance = TennisMatch()
        }
        return Singleton.sharedInstance
    }
    
}
