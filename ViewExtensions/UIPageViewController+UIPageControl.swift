//
//  UIPageViewController+UIPageControl.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-10-17.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
    
    public var pageControl: UIPageControl? {
        
        let subviews = self.view.subviews
        for view in subviews {
            if let pageControlView = view as? UIPageControl {
                return pageControlView
            }
        }
        return nil
    }
}
