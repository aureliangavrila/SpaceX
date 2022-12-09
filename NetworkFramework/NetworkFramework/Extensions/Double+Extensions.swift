//
//  Double+Extensions.swift
//  NetworkingFramework
//
//  Created by Aurelian Gavrila on 15.11.2022.
//

import Foundation

extension Double {
    func getDateFromUnix() -> Date {
        Date(timeIntervalSince1970: self)
    }
    
    func getMissionDateString() -> String {
        let date = getDateFromUnix()
        
        return date.getDateComponents()
    }
    
    func getDateDifference() -> Int {
        let date = getDateFromUnix()
        let calendar = Calendar.current
        
        return calendar.numberOfDaysBetween(date, and: Date())
    }
}
