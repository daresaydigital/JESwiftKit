//
//  AnimationContainer.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-11-14.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import SwifterSwift

/// A wrapper around a LOTAnimationView for more convenient access via storyboard
public class LOTAnimationContainer: UIView {
    
    private var initialLayout = false
    public private(set) var lottieView: LOTAnimationView?
    private var _animationName: String?
    
    private var shouldBePlaying: Bool = false
    

    @IBInspectable public var animationName: String? {
        didSet {
            if let name = animationName, name != _animationName {
                self.subviews.forEach { $0.removeFromSuperview() }
                lottieView = LOTAnimationView(name: name)
                if let lot = lottieView {
                    lottieView?.loopAnimation = loopAnimation
                    lottieView?.autoReverseAnimation = autoReverseAnimation
                    self.addSubview(lot)
                    lot.fillToSuperview()
                    self.layoutIfNeeded()
                }
            }
            _animationName = animationName
        }
    }
    
    @IBInspectable public var loopAnimation: Bool = false {
        didSet {
            if lottieView != nil {
                lottieView?.loopAnimation = loopAnimation
            }
        }
    }
    
    @IBInspectable public var autoReverseAnimation: Bool = false {
        didSet {
            if lottieView != nil {
                lottieView?.autoReverseAnimation = autoReverseAnimation
            }
        }
    }
    
    /// play the animation oncpoisible
    @IBInspectable public var autoplay: Bool = false 
    
    override public func didMoveToWindow() {
        super.didMoveToWindow()
        if self.window != nil {
            if !initialLayout && autoplay {
                self.lottieView?.play()
            }
            initialLayout = true

            NotificationCenter.default.addObserver(self, selector: #selector(prepareForBackground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(resumePlay), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        }
    }
    
    @objc public func prepareForBackground() {
        self.shouldBePlaying = self.lottieView?.isAnimationPlaying ?? false
    }
    
    @objc public func resumePlay() {
        if let animView = self.lottieView {
            if !animView.isAnimationPlaying && self.shouldBePlaying {
                animView.play()
            }
        }
    }
}

extension LOTAnimationView {
    
    /// Allow animation to complete cycle before stopping
    public func stopEventually() {
        self.loopAnimation = false
        
        self.completionBlock = { (completed) in
            self.stop()
            self.loopAnimation = true
        }
    }
}
