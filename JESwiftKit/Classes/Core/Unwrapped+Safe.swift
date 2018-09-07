//
//  Unwrapped+Safe.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-10-13.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation

/// Takes an implicitly unwrapped optional and returns a wrapped optional
func safe<T>(_ unwrapped: T!) -> T? {
    
    if let proof = unwrapped {
        return proof
    } else {
        return nil
    }
}
