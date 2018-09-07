//
//  PopoverPresentation.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-07-09.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Handle in general presentation of UIActionSheet and UIActivityViewController on iPad
    func handlePopoverPresentation(_ sender: Any) {
        
        if let popover = self.popoverPresentationController {
            var sendView: UIView?
            switch sender {
            case let button as UIButton:
                sendView = button
            case let gesture as UITapGestureRecognizer:
                sendView = gesture.view
            default:
                break
            }
            
            if let sendView = sendView {
                // popover points to button
                popover.sourceView = sendView
                popover.sourceRect = CGRect(x: sendView.bounds.origin.x, y: sendView.bounds.origin.y, width: sendView.bounds.width, height: sendView.bounds.height)
                popover.permittedArrowDirections = [UIPopoverArrowDirection.any]
            } else {
                // popover control center the popover on an iPad
                popover.sourceView = self.view
                popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
        }
    }
}
