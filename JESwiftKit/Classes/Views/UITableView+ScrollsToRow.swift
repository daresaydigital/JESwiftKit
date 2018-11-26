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
    
    func scrollToTopRow(animated: Bool) {
        let zeroIndex = IndexPath(item: 0, section: 0)
        if self.numberOfSections > 0 && self.numberOfRows(inSection: zeroIndex.section) > 0 {
            self.scrollToRow(at: zeroIndex, at: .top, animated: animated)
        }
    }
    
    func scrollToBottomRow(animated: Bool) {
        let sectionCount = self.numberOfSections
        if sectionCount > 0 {
            let rowCount = self.numberOfRows(inSection: sectionCount - 1)
            if rowCount > 0 {
                let lastIndex = IndexPath(row: rowCount - 1, section: sectionCount - 1)
                self.scrollToRow(at: lastIndex, at: .bottom, animated: animated)
            }
        }
    }
}
