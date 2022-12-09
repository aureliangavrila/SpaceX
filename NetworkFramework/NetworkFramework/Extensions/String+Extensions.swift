//
//  String+Extensions.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 14.11.2022.
//

import Foundation

extension DateFormatter {
    static let fullDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
}

extension String {
    
    func getDate() -> Date? {
        return DateFormatter.fullDateFormatter.date(from: self)
    }
    
    func getMissionDateString() -> String {
        guard let date = getDate() else { return "-" }
        return date.getDateComponents()
    }
    
    func getDateDifference() -> Int? {
        guard let date = getDate() else { return nil }
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? .current
        
        return calendar.numberOfDaysBetween(date, and: Date())
    }
}

