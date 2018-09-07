//
//  DateFormatters.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-11-01.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    public convenience init(timeStyle: DateFormatter.Style, dateStyle: DateFormatter.Style) {
        self.init()
        self.timeStyle = timeStyle
        self.dateStyle = dateStyle
    }
    
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension Date {
    
    public func isAfter(_ date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    public func isBefore(_ date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    public func isSame(_ date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }

    public init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: milliseconds * 1E-3)
    }
    
    public var asMillis: Double {
        return self.timeIntervalSince1970 / 1E-3
    }
}
