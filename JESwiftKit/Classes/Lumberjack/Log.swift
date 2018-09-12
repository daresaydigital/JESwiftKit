//
//  Log.swift
//  SmartPlug
//
//  Created by Hans Sjunesson on 2017-08-23.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import CocoaLumberjack

public final class CustomDDLogFormatter: NSObject, DDLogFormatter {

    public func format(message logMessage: DDLogMessage) -> String? {
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

// Workaround for Swift
// https://github.com/CocoaLumberjack/CocoaLumberjack/issues/643#issuecomment-156570032
extension DDAbstractLogger {
    
    public func swiftCompatMessage(message logMessage: DDLogMessage) -> String? {
        var logMsg: String? = logMessage.message
        
        if let ivar = class_getInstanceVariable(object_getClass(self), "_logFormatter"),
            let formatter = object_getIvar(self, ivar) as? DDLogFormatter {
            logMsg = formatter.format(message: logMessage)
        }
        
        return logMsg
        
    }
}
