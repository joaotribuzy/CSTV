//
//  Date+Extensions.swift
//  CSTV
//
//  Created by João Tribuzy on 29/08/24.
//

import Foundation

extension Date {

    func getDateDescription(from matchStatus: Status) -> String {
        if matchStatus == .running {
            return "AGORA"
        }
        
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let timeString = formatter.string(from: self)
        
        if calendar.isDate(self, inSameDayAs: .now) {
            return "Hoje, \(timeString)"
        }
        
        if let preferredLanguage = Locale.preferredLanguages.first {
            formatter.locale = Locale(identifier: preferredLanguage)
        } else {
            formatter.locale = Locale.current
        }
        
        formatter.dateFormat = "EEE"
        let dayString = formatter.string(from: self).replacingOccurrences(of: ".", with: "").capitalizedFirstLetter()
        
        return "\(dayString), \(timeString)"
    }

}
