//
//  UICollectionViewDelegateFlowLayout+Fit.swift
//  SmartPlug
//
//  Created by Joseph Elliott on 2017-10-12.
//  Copyright © 2017 Daresay. All rights reserved.
//

import Foundation
import UIKit

/// Supply a minimum cell size and then fit cells to the collection view depending on the minimum
/// For example, you could have 3 cells per row on smaller devices, but more on larger devices.
/// Will attempt to fill all available space without exceeding the minimum.
public protocol UICollectionViewGrowToFitFlowLayoutDelegate: UICollectionViewFitFlowLayoutDelegate {

    /// Minimum size of items in this collection.  They will attempt to scale to fit the available space.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumItemWidthIn section: Int) -> CGFloat
}

extension UICollectionViewGrowToFitFlowLayoutDelegate {
    
    public func cellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize {

        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let minimumItemWidth = self.collectionView(collectionView, layout: flowLayout, minimumItemWidthIn: section)
            let aspectRatio = self.collectionView(collectionView, layout: flowLayout, aspectRatioIn: section)

            let usableWidth = collectionView.frame.size.width - flowLayout.minimumInteritemSpacing
            
            let cellWidthWithSpacing = flowLayout.minimumInteritemSpacing + minimumItemWidth
            let numberOfCells = floor(usableWidth / cellWidthWithSpacing)
            
            // now that we know how many can fit, scale up what we have
            let scaledCellWidth = (usableWidth / numberOfCells) - flowLayout.minimumInteritemSpacing
            
            let scaledCellHeight = scaledCellWidth / aspectRatio
            
            return CGSize(width: floor(scaledCellWidth), height: floor(scaledCellHeight))
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

/// Fix the number of items per row, then scale cells to fit space.  Option to set maximum item width which will override cells per row.
public protocol UICollectionViewFixItemNumberLayoutDelegate: UICollectionViewFitFlowLayoutDelegate {
    
    /// The number of cells to include in each row. Can be overridden if maximumItemWidth is also implemented.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, cellsPerRowIn section: Int) -> Int
    
    /// Set a maximum item width which the cells will scale to while maintaining a fixed number in each row.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maximumItemWidthIn section: Int) -> CGFloat
}

extension UICollectionViewFixItemNumberLayoutDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maximumItemWidthIn section: Int) -> CGFloat {
        return CGFloat(Int.max)
    }

    public func cellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let maxItemWidth = self.collectionView(collectionView, layout: flowLayout, maximumItemWidthIn: section)
            let aspectRatio = self.collectionView(collectionView, layout: flowLayout, aspectRatioIn: section)
            
            let usableWidth = collectionView.frame.size.width - flowLayout.minimumInteritemSpacing
            
            // now that we know how many can fit, scale up what we have
            let cellsPerRow = self.collectionView(collectionView, layout: flowLayout, cellsPerRowIn: section)
            let scaledCellWidth = (usableWidth / CGFloat(cellsPerRow)) - flowLayout.minimumInteritemSpacing
            
            let actualCellWidth = min(scaledCellWidth, maxItemWidth)
            
            let actualCellHeight = actualCellWidth / aspectRatio
            
            return CGSize(width: floor(actualCellWidth), height: floor(actualCellHeight))
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

/// General protocol to encompass various types of cell fitting.
public protocol UICollectionViewFitFlowLayoutDelegate: class, UICollectionViewDelegateFlowLayout {
    
    /// Aspect ratio of the cells in this section for scaling.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, aspectRatioIn section: Int) -> CGFloat
    
    /// The size of cells in this section.
    func cellSize(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> CGSize
    
    /// The number of cells per row in this section.
    func cellsPerRow(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> Int
}

extension UICollectionViewFitFlowLayoutDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, aspectRatioIn section: Int) -> CGFloat {
        return 1.0
    }

    public func cellsPerRow(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> Int {
        var numberOfCells = 0
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let usableWidth = collectionView.frame.size.width
            let cellSize = self.cellSize(collectionView, layout: flowLayout, section: section).width

            var runningCellSizeTotal: CGFloat = 0
            while true {
                
                runningCellSizeTotal += cellSize

                // calculate the number of spaces for this number of cells (plus one).
                let spaceSize = CGFloat(numberOfCells) * flowLayout.minimumInteritemSpacing
                if (runningCellSizeTotal + spaceSize) > usableWidth {
                    break
                }
                
                // the cell can fit, add it.
                numberOfCells += 1
            }
        }
        return numberOfCells
    }
}
