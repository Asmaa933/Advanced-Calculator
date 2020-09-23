//
//  OperationCell.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

/// Class Custom UICollectionViewCell
class OperationCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var operLabel: UILabel!
    
    /// Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Set label text value
    var text: String?{
        didSet{
            operLabel.text = text
        }
    }
    
    /// Maxmium width for cell
    var maxWidth: CGFloat?{
        didSet{
            operLabel.preferredMaxLayoutWidth = maxWidth ?? 0
        }
    }
}
