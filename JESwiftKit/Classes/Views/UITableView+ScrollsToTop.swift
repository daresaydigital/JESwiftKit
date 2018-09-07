//
//  UITableView+ScrollsToTop.swift
//  TeliaZone
//
//  Created by Joseph Elliott on 2018-04-24.
//  Copyright © 2018 Telia Zone. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func scrollToTopRow() {
        let zeroIndex = IndexPath(item: 0, section: 0)
        if self.numberOfSections > 0 && self.numberOfRows(inSection: zeroIndex.section) > 0 {
            self.scrollToRow(at: zeroIndex, at: .top, animated: false)
        }
    }
}
