//
//  Date+String.swift
//  YLKitSwift
//
//  Created by Yeonluu on 2017/12/4.
//  Copyright © 2017年 Yeonluu. All rights reserved.
//

import Foundation

extension Date {

    public func formattedDateWithFormat(format:String!) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone.system
        formatter.locale = NSLocale.autoupdatingCurrent
        return formatter.string(from: self)
    }

    public func stringWithDateFormat(format:String!) -> String {
//        let key: UnsafeRawPointer! = UnsafeRawPointer(bitPattern: format.hashValue)
//        var value = objc_getAssociatedObject(self, key)
//        if value == nil {
//            value = self.formattedDateWithFormat(format: format)
//            objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        }
//        return value as! String
        return self.formattedDateWithFormat(format: format);
    }
    
    public var timeString: String {
        return self.stringWithDateFormat(format: "HH:mm")
    }
    
    public var fullTimeString: String {
        return self.stringWithDateFormat(format: "HH:mm:ss")
    }
    
    public var dateString: String {
        return self.stringWithDateFormat(format: "MM-dd")
    }
    
    public var fullDateString: String {
        return self.stringWithDateFormat(format: "yyyy-MM-dd")
    }
    
    public var dateAndTimeString: String {
        return self.stringWithDateFormat(format: "MM-dd HH:mm")
    }
    
    public var fullDateAndTimeString: String {
        return self.stringWithDateFormat(format: "yyyy-MM-dd HH:mm")
    }
    
    public var fullDateAndFullTimeString: String {
        return self.stringWithDateFormat(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    public var dayString: String {
        let days = ["前天", "昨天", "今天", "明天", "后天"]
        for i in -2...2 {
            if self.isSameDayAsOtherDate(Date.init(timeIntervalSinceNow: TimeInterval(60*60*24*i))) {
                return days[i+2]
            }
        }
        return self.dateString
    }
    
    public var dayAndTimeString: String {
        return self.dayString + " " + self.timeString
    }
    
    public var dayAndFullTimeString: String {
        return self.dayString + " " + self.fullTimeString
    }
    
    public var weekdayString: String {
        switch self.weekday {
        case 0:
            return "周日"
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        default:
            return ""
        }
    }
}

extension Date {
    
    public func isEarlierThan(_ date: Date) -> Bool {
        return self.timeIntervalSince1970 < date.timeIntervalSince1970
    }
 
    public func isLaterThan(_ date: Date) -> Bool {
        return self.timeIntervalSince1970 > date.timeIntervalSince1970
    }
    
    public func isEarlierThanOrEqualTo(_ date: Date) -> Bool {
        return self.timeIntervalSince1970 <= date.timeIntervalSince1970
    }
    
    public func isLaterThanOrEqualTo(_ date: Date) -> Bool {
        return self.timeIntervalSince1970 >= date.timeIntervalSince1970
    }
    
    public func isSameDayAsOtherDate(_ date: Date) -> Bool {
        return self.normalizeDate == date.normalizeDate
    }
    
    var normalizeDate: Date? {
        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: self)
        return calendar.date(from: dateComponents)
    }
}


extension Date {
    
    static func daysOfMonth(month: Int, atYear year: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            return (year%400 == 0 || (year%100 != 0 && year%4 == 0)) ? 29 : 28
        default:
            return 30
        }
    }
    
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        
        guard let date = Calendar.current.date(from: dateComponents) else {
            self = Date()
            return
        }
        self = date
    }
    
    public var year: Int {
        return component(.year)
    }
    
    public var month: Int {
        return component(.month)
    }
    
    public var week: Int {
        return component(.weekday)
    }
    
    public var day: Int {
        return component(.day)
    }
    
    public var hour: Int {
        return component(.hour)
    }
    
    public var minute: Int {
        return component(.minute)
    }
    
    public var second: Int {
        return component(.second)
    }
    
    public var weekday: Int {
        return component(.weekday)
    }
    
    public func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
}
