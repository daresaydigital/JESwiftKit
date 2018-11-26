//
//  UITableViewCellWithContainer.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-03-19.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import UIKit
import SwifterSwift

open class UITableViewCellWithContainer: UITableViewCell {
    
    public var embeddedController: UIViewController?
    @IBOutlet weak public var containerView: UIView?
    
    override open func prepareForReuse() {
        if let controller = self.embeddedController {
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
    
    /// Initialize a UITableViewCell with an embedded view controller and a reference to its parent.
    public func configureCell(embeddedController: UIViewController, parentViewController: UIViewController) {
        
        // we're going to replace whatever's in the cell with our own stuff
        self.containerView?.removeSubviews()
        
        //for some reason this isn't getting initialized properly...
        if let containerView = self.containerView {
            self.frame = CGRect(x: containerView.frame.origin.x, y: containerView.frame.origin.y, width: parentViewController.view.frame.size.width, height: containerView.frame.origin.y)
        }
        //set the new embedded controller.
        self.embeddedController = embeddedController
        
        // Add the page view controller into the container view.
        parentViewController.addChild(embeddedController)
        
        self.embeddedController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.translatesAutoresizingMaskIntoConstraints = false
        self.containerView?.addSubview(embeddedController.view)
        embeddedController.view.fillToSuperview()
        
        self.embeddedController?.didMove(toParent: parentViewController)

    }
}
