//
//  OperationCell.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

class OperationCell: UICollectionViewCell {
    
    @IBOutlet private weak var operLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var text: String?{
        didSet{
            operLabel.text = text
        }
    }
    var maxWidth: CGFloat?{
        didSet{
            operLabel.preferredMaxLayoutWidth = maxWidth ?? 0
        }
    }
}
