//
//  CollectionExtensions.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-02-16.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation

extension Sequence {
    
    /// Check to ensure a condition is true for all elements in sequence.
    /// true for empty sequences.
    public func forAll(where predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            do {
                let result = try predicate(item)
                if !result {
                    return false
                }
            }
        }
        
        return true
    }
}

extension Sequence where Element: Equatable {
    
    /// Drop duplicate elements from an array while maintaining ordering.
    public func distinct() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
    
    public func distinctBy<T: Hashable>(map: ((Element) -> (T))) -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var result = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                result.append(value)
            }
        }
        
        return result
    }
}
