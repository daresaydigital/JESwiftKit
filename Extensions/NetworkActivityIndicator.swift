//
//  UIApplication+Extensions.swift
//  SmartPlug
//
//  Created by Hans Sjunesson on 2017-08-18.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit

var networkActivityCount = 0

extension UIApplication {
    public func showNetworkActivityIndicator() {
        DispatchQueue.main.async {
            if networkActivityCount == 0 {
                self.isNetworkActivityIndicatorVisible = true
            }
            networkActivityCount += 1
        }
    }

    public func hideNetworkActivityIndicator() {
        DispatchQueue.main.async {
            networkActivityCount -= 1
            if networkActivityCount <= 0 {
                networkActivityCount = 0
                self.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
