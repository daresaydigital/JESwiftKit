//
//  UIViewController+Modal.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-03-14.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Determine if a view controller has been presented modally or not.
    /// http://stackoverflow.com/a/33136632 and http://stackoverflow.com/a/16764496
    public var isModallyPresented: Bool {
        
        if self.presentingViewController?.presentedViewController == self {
            return true
        }
        if self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController && self == self.navigationController?.viewControllers[0] {
            return true
        }
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
