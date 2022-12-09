//
//  Date+Extensions.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import Foundation

extension Date {
    
    func getDateComponents() -> String {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? .current
        
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let hour = calendar.component(.hour, from: self)
        let mins = calendar.component(.minute, from: self)
        let secs = calendar.component(.second, from: self)
        
        return "\(year)-\(month)-\(day) at \(hour):\(mins):\(secs)"
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
            let fromDate = startOfDay(for: from)
            let toDate = startOfDay(for: to)
            let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
            
            return numberOfDays.day!
        }
}
