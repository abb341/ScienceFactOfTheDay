//
//  DateHelper.swift
//  Tips
//
//  Created by Aaron Brown on 7/15/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import Foundation

class DateHelper {

    static func dateTodayAsInt() -> Int {
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.CalendarUnitMonth, fromDate: NSDate())
        let day = calendar.component(.CalendarUnitDay, fromDate: NSDate())
        let year = calendar.component(.CalendarUnitYear, fromDate: NSDate())
        var dateTodayAsInt = month*1000000 + day*10000 + year
        return dateTodayAsInt
    }
    
    static func recentDays() -> [Int] {
        let calendar = NSCalendar.currentCalendar()
        let month = calendar.component(.CalendarUnitMonth, fromDate: NSDate())
        let day = calendar.component(.CalendarUnitDay, fromDate: NSDate())
        let year = calendar.component(.CalendarUnitYear, fromDate: NSDate())
        
        var recentDatesAsInts: [Int] = []
        
        var indexDay = day
        for var i: Int = 0; i < 7; i++ {
            indexDay--
            recentDatesAsInts.append(i)
            recentDatesAsInts[i] = month*1000000 + indexDay*10000 + year
        }
        
        return recentDatesAsInts
    }
    
    static func formatForDate(var forDate: Int) -> String {
        //Find Month
        var month = forDate/1000000
        
        //Find Day
        var monthAndDay = forDate/10000
        var day: Int = 0
        for var i = 0; i<99; i++ {
            if (monthAndDay - i == month*100) {
                day = i
                i+=99
            }
        }
        
        //Find Year
        var year = forDate - month*1000000 - day*10000
        
        let formattedForDate = "\(month)/\(day)/\(year)"
        return formattedForDate
    }
}
