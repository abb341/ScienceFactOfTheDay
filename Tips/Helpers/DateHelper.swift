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
        
        var recentDatesAsInts: [Int] = [1,2,3,4,5,6,7]
        var indexDay = day
        for var i: Int = 0; i < 7; i++ {
            indexDay--
            recentDatesAsInts[i] = month*1000000 + indexDay*10000 + year
        }
        
        return recentDatesAsInts
    }
    
    static func formatForDate(var forDate: Int) -> String {
        //Find Month
        var month = forDate/1000000
        println("Month: \(month)")
        
        //Find Day
        var monthAndDay = forDate/10000
        println("Month and Day: \(monthAndDay)")
        var day: Int = 0
        for var i = 0; i<99; i++ {
            if (monthAndDay - i == month*100) {
                day = i
                i+=99
            }
        }
        println("Day: \(day)")
        
        //Find Year
        var year = forDate - month*1000000 - day*10000
        println("Year: \(year)")
        
        let formattedForDate = "\(month)/\(day)/\(year)"
        return formattedForDate
    }
}
