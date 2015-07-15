//
//  DateHelper.swift
//  Tips
//
//  Created by Aaron Brown on 7/15/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation

class DateHelper {

    func dateTodayAsInt() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.CalendarUnitMonth, fromDate: NSDate())
        let day = calendar.component(.CalendarUnitDay, fromDate: NSDate())
        let year = calendar.component(.CalendarUnitYear, fromDate: NSDate())
        var dateTodayAsInt = month*1000000 + day*10000 + year
        return dateTodayAsInt
    }
    
    func recentDays() -> [Int] {
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.CalendarUnitMonth, fromDate: NSDate())
        let day = calendar.component(.CalendarUnitDay, fromDate: NSDate())
        let year = calendar.component(.CalendarUnitYear, fromDate: NSDate())
        
        var recentDatesAsInts: [Int] = [1,2,3,4,5,6,7]
        var indexDay = day
        for var i: Int = 0; i < 7; i++ {
            indexDay--
            recentDatesAsInts[i] = month*1000000 + indexDay*10000 + year
        }
        
        return recentDatesAsInts
    }
}
