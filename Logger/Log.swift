//
//  Log.swift
//  SmartPlug
//
//  Created by Hans Sjunesson on 2017-08-23.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import CocoaLumberjack

class CustomDDLogFormatter: NSObject, DDLogFormatter {

    func format(message logMessage: DDLogMessage) -> String? {
        switch logMessage.flag {
        case .error:
            return String(format: "[DDLog] 💥 %@", logMessage.message)
        case .warning:
            return String(format: "[DDLog] ⚠️ %@", logMessage.message)
        case .info:
            return String(format: "[DDLog] ℹ️ %@", logMessage.message)
        case .debug:
            return String(format: "[DDLog] 🐞 %@", logMessage.message)
        default:
            return String(format: "[DDLog] 💬 %@", logMessage.message)
        }
    }
}

public func DDLogError(_ message: String, error: Error?) {
    DDLogError(String(format: "%@ Error: %@", message, error.debugDescription))
}
