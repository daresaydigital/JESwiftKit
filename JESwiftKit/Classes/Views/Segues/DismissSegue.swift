//
//  DismissSegue.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-09-22.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit

///Dismiss a controller from the storyboard without specifying a destination
public class DismissSegue: UIStoryboardSegue {
    override public func perform() {
        self.source.presentingViewController?.dismiss(animated: true, completion: {})
    }
}

///Dismiss a controller from the storyboard with a destination in mind
public class DismissWithDestination: UIStoryboardSegue {
    override public func perform() {

        func dismiss(_ controller: UIViewController?) {

            //if the controller is the destination, we want it to dismiss
            //deal also with navigation controllers.
            if let control = controller {
                if control == self.destination {
                    control.dismiss(animated: true, completion: {})
                } else if let navControl = control as? UINavigationController {
                    if navControl.viewControllers.contains(where: { (viewController) -> Bool in return viewController.isKind(of: type(of: self.destination))}) {
                        navControl.dismiss(animated: true, completion: {})
                    }
                } else {
                    dismiss(control.presentingViewController)
                }
            }

            //if the controller is not the destination, go one level deeper
            //if controller is nil, we fucked up, quit
        }

        dismiss(self.source.presentingViewController)

    }
}

///Dismiss all presented view controllers in the stack
public class DismissToRoot: UIStoryboardSegue {
    
    override public func perform() {

        var presenter: UIViewController? = self.source.presentingViewController
        
        while presenter?.presentingViewController != nil {

            presenter = presenter?.presentingViewController
        }
        
        presenter?.dismiss(animated: true, completion: {})
        
    }
}
