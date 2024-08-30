//
//  Date+Extensions.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import Foundation

extension Date {
    private func addDay() -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = 1

        let calendar = Calendar.current
        guard let newDate = calendar.date(byAdding: dateComponent, to: self) else { return Date() }
        return newDate
    }
    
    static func getTodayDateRangeString() -> String {
        
        let today = Calendar.current.startOfDay(for: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        
        
        return "\(dateFormatter.string(from: today)),\(dateFormatter.string(from: today.addDay()))"
        
    }
}
