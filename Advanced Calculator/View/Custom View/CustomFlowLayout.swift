//
//  FlowLayout.swift
//  Advanced Calculator
//
//  Created by Esma on 9/22/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

/// Calculate row of collection view
class Row {
    // MARK: - Variables
    /// Array of UICollectionViewLayoutAttributes that manages the layout-related attributes for a given item in a collection view.
    var attributes = [UICollectionViewLayoutAttributes]()
    
    /// Space between cells
    var spacing: CGFloat = 0
    
    /// Initialization  an instance of a class
    /// - Parameter spacing: space between cells
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    /// Add  attribute to attributes array
    /// - Parameter attribute: layout object that manages the layout-related attributes for a given item in a collection view.
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }
    
    /// Setup label layout
    /// - Parameter collectionViewWidth: collection view width
    func labelLayout(collectionViewWidth: CGFloat) {
        let padding = 10
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

/// Custom flow layout for collection view.
class CustomFlowLayout: UICollectionViewFlowLayout {
    /// Returns the layout attributes for all of the cells and views in the specified rectangle.
    /// - Parameter rect: The rectangle (specified in the collection view’s coordinate system) containing the target views.
    /// - Returns: An array of UICollectionViewLayoutAttributes objects representing the layout information for the cells and views. The default implementation returns nil.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        var rows = [Row]()
        var currentRowY: CGFloat = -1
        
        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
        }
        rows.forEach { $0.labelLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}
