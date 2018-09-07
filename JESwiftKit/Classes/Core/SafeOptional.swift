//
//  SafeOptional.swift
//  CocoaLumberjack
//
//  Created by Joseph Elliott on 2018-09-07.
//

import Foundation

public class SafeOptional {
    
    /// Takes an implicitly unwrapped optional and returns a wrapped optional
    public static func makeSafe<T>(_ unwrapped: T!) -> T? {
        
        if let proof = unwrapped {
            return proof
        } else {
            return nil
        }
    }
}
