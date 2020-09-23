//
//  BorderedLabel.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

/// Custom label with border and padding
class BorderedLabel: UILabel {
    
    // MARK: - Variables
    private let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 8
    }
    
    /// Draws the label’s text, or its shadow, in the specified rectangle.
    /// - Parameter rect: The rectangle in which to draw the text.
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    /// The natural size for the receiving view, considering only properties of the view itself.
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
}
