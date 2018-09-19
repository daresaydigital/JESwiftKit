//
//  UIButton+FontAppearance.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2018-09-19.
//  Copyright © 2018 Daresay. All rights reserved.
//

import UIKit

public extension UIButton {
    
    @objc dynamic var titleLabelFont: UIFont! {
        get { return self.titleLabel?.font }
        set { self.titleLabel?.font = newValue }
    }
}
