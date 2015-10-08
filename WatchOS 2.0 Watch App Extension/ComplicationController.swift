//
//  ComplicationController.swift
//  WatchOS 2.0 Watch App Extension
//
//  Created by Raphael Neuenschwander on 28.09.15.
//  Copyright © 2015 Raphael Neuenschwander. All rights reserved.
//

import ClockKit

let MatchDuration = NSTimeInterval(60 * 45)

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let startDate = timelineEntryDateForMatch(TennisMatch.sharedInstance().firstMatch())
        handler(startDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        let endDate = TennisMatch.sharedInstance().lastMatch().time.dateByAddingTimeInterval(MatchDuration)
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        
        getTimelineEntriesForComplication(complication, beforeDate: NSDate(), limit: 1) { (entries) -> Void in
            handler(entries?.first)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        
        var entries = [CLKComplicationTimelineEntry]()
        
        var match: Match? = TennisMatch.sharedInstance().lastMatch()
        while let thisMatch = match {
            let thisEntryDate = timelineEntryDateForMatch(thisMatch)
            if date.compare(thisEntryDate) == .OrderedDescending {
                let tmpl = templateForMatch(thisMatch, complication: complication)!
                let entry = CLKComplicationTimelineEntry(date: thisEntryDate, complicationTemplate: tmpl)
                entries.append(entry)
                if entries.count == limit { break }
            }
            match = TennisMatch.sharedInstance().previousMatch(thisMatch)
        }
        handler(entries)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        
        var entries = [CLKComplicationTimelineEntry]()
        
        var match: Match? = TennisMatch.sharedInstance().firstMatch()
        while let thisMatch = match {
            let thisEntryDate = timelineEntryDateForMatch(thisMatch)
            if date.compare(thisEntryDate) == .OrderedAscending {
                let tmpl = templateForMatch(thisMatch, complication: complication)!
                let entry = CLKComplicationTimelineEntry(date: thisEntryDate, complicationTemplate: tmpl)
                entries.append(entry)
                if entries.count == limit { break }
            }
            match = TennisMatch.sharedInstance().nextMatch(thisMatch)
        }
        handler(entries)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        switch complication.family {
            
        case CLKComplicationFamily.ModularLarge:
            let tmpl = CLKComplicationTemplateModularLargeStandardBody()
            
            tmpl.headerImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Tennis")!)
            
            tmpl.headerTextProvider = CLKSimpleTextProvider(text: "Match Schedule")
            tmpl.body1TextProvider = CLKSimpleTextProvider(text: "Player vs Player")
            
            handler(tmpl)
            
        case CLKComplicationFamily.ModularSmall:
            let tmpl = CLKComplicationTemplateModularSmallColumnsText()
            
            tmpl.row1Column1TextProvider = CLKSimpleTextProvider(text: "RF")
            tmpl.row2Column1TextProvider = CLKSimpleTextProvider(text: "ND")
            tmpl.row1Column2TextProvider = CLKSimpleTextProvider(text: "0")
            tmpl.row2Column2TextProvider = CLKSimpleTextProvider(text: "0")
            
            handler(tmpl)
            
        default: break
        }
    }
    
    //MARK: - Convenience
    
    private func templateForMatch(match: Match, complication: CLKComplication) -> CLKComplicationTemplate? {
        
        switch complication.family {
        case .ModularLarge:
            let tmpl = CLKComplicationTemplateModularLargeStandardBody()
            
            let tennisBall = UIImage(named: "Tennis")!
            tmpl.headerImageProvider = CLKImageProvider(onePieceImage: tennisBall)
            
            tmpl.headerTextProvider = CLKTimeTextProvider(date: match.time)
            tmpl.body1TextProvider = CLKSimpleTextProvider(text: "\(match.playerOne) vs \(match.playerTwo)")
            
            return tmpl
            
        case .ModularSmall:
            let tmpl = CLKComplicationTemplateModularSmallColumnsText()
            
            tmpl.row1Column1TextProvider = CLKSimpleTextProvider(text: match.playerOneInitials)
            tmpl.row1Column2TextProvider = CLKSimpleTextProvider(text: "423")
            tmpl.row2Column1TextProvider = CLKSimpleTextProvider(text: match.playerTwoIntials)
            tmpl.row2Column2TextProvider = CLKSimpleTextProvider(text: "631")
            
            return tmpl
            
        default: break
        }
    return nil
    }
    
    private func timelineEntryDateForMatch(match: Match) -> NSDate {
        if let previousMatch = TennisMatch.sharedInstance().previousMatch(match) {
            return previousMatch.time.dateByAddingTimeInterval(MatchDuration)
        } else {
            
            return match.time.dateByAddingTimeInterval(-6 * 60 * 60)
    
        }
    }
}
