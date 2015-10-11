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
            let playerOne = randomPlayer()
            let playerTwo = randomPlayer()
            let match = Match(time: NSDate(timeIntervalSinceNow: Double(60 * 60 * i)), playerOne: playerOne.0, playerOneInitials: playerOne.1, playerTwo: playerTwo.0, playerTwoIntials: playerTwo.1, index: i)
            createdMatched.append(match)
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
    
    func randomPlayer () -> (String,String) {
        
        switch arc4random() % 8 {
        case 0: return ("Federer","RF")
        case 1: return ("Wawrinka","SW")
        case 2: return ("Djokovic","ND")
        case 3: return ("Nadal","RN")
        case 4: return ("Murray","AM")
        case 5: return ("Berdych","TB")
        case 6: return ("Nishikori","KN")
        case 7: return ("Ferrer","DF")
        default: return ("Gasquet","RG")
        }
    }
    
    class func sharedInstance() -> TennisMatch {
        struct Singleton {
            static var sharedInstance = TennisMatch()
        }
        return Singleton.sharedInstance
    }
}
