//
//  ReplaceSegue.swift
//  SmartPlug
//
//  Created by Hans Sjunesson on 2017-08-15.
//  Copyright © 2017 Daresay. All rights reserved.
//

import UIKit

public class ReplaceSegue: UIStoryboardSegue {
    override public func perform() {
        source.view.window?.rootViewController = destination
    }
}
