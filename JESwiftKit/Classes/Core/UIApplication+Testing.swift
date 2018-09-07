//
//  UIApplication+Testing.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-06-05.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /// If we are running unit tests
    var isTesting: Bool {
        return NSClassFromString("XCTest") != nil
    }
}
