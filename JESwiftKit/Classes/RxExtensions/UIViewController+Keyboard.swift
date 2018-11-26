//
//  UIViewController+Keyboard.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-10-17.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    
    /// Initialize the adjustment of the keyboard to a particular constraint.
    /// Call this in your viewDidLoad()
    public func enableKeyboardAdjustmentFor(_ constraint: NSLayoutConstraint, disposedBy bag: DisposeBag, padding: CGFloat = 8.0) {
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification).subscribe(onNext: { [weak self] (note) in
            if let strongSelf = self {
                strongSelf.updateKeyboardFrame(note, constraint: constraint, padding: padding)
            }
        }).disposed(by: bag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).subscribe(onNext: { [weak self] (note) in
            if let strongSelf = self {
                strongSelf.updateKeyboardFrame(note, constraint: constraint, padding: padding)
            }
        }).disposed(by: bag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).subscribe(onNext: { [weak self] (note) in
            if let strongSelf = self {
                strongSelf.updateKeyboardFrame(note, constraint: constraint, padding: padding)
            }
        }).disposed(by: bag)
        
    }
    
    /// Adjusts the providided constraint according to UIKeyboardWillChangeFrame, UIKeyboardWillShow and UIKeyboardWillHide Notifications
    /// To set up the storyboard, set a constraint from the bottom of screen to the bottom of the view you want to move up to >= 0
    /// Set the constraint to priority 1000
    private func updateKeyboardFrame(_ notification: Notification, constraint: NSLayoutConstraint, padding: CGFloat) {
        
        guard let newKeyboardRect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let keyboardAnimationCurve = ((notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int).flatMap { UIView.AnimationCurve(rawValue: $0) }) else {
                return
        }
        
        UIView.animate(withDuration: keyboardAnimationDuration) {
            UIView.setAnimationCurve(keyboardAnimationCurve)
            
            if newKeyboardRect.size.height == 0 || newKeyboardRect.origin.y >= UIScreen.main.bounds.size.height {
                constraint.constant = 0
            } else {
                constraint.constant = newKeyboardRect.size.height + padding
            }
            
            self.view.layoutIfNeeded()
        }
    }
}
