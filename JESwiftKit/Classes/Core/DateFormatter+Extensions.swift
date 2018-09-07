//
//  DateFormatters.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-11-01.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    convenience init(timeStyle: DateFormatter.Style, dateStyle: DateFormatter.Style) {
        self.init()
        self.timeStyle = timeStyle
        self.dateStyle = dateStyle
    }
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension Date {
    
    func isAfter(_ date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    func isBefore(_ date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    func isSame(_ date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }

    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: milliseconds * 1E-3)
    }
    
    public var asMillis: Double {
        return self.timeIntervalSince1970 / 1E-3
    }
}
