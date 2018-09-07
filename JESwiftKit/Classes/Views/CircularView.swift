//
//  CircularImageView.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-01-17.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import UIKit

@IBDesignable
public class CircularView: UIView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = (self.frame.width / 2.0)
    }
}

@IBDesignable
public class CircularImageView: UIImageView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = (self.frame.width / 2.0)
    }
}
