//
//  Optional+Extensions.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-01-26.
//  Copyright © 2018 Telia Zone. All rights reserved.
// Improvements to optional handling from http://www.russbishop.net/improving-optionals

import Foundation

protocol OptionalType: ExpressibleByNilLiteral { }

// Optional already has an ExpressibleByNilLiteral conformance
// so we just adopt the protocol
extension Optional: OptionalType { }
extension Optional where Wrapped: OptionalType {
    
    /// Flatten out double optionals
    func flatten() -> Wrapped {
        switch self {
        case let .some(value):
            return value
        case .none:
            return nil
        }
    }
}

extension Optional {
    
    // Cast an optional to array of single object or empty array if not there. 
    var toArray: [Wrapped] {
        switch self {
        case let .some(value):
            return [value]
        case .none:
            return []
        }
    }
}
