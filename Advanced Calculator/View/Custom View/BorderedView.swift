//
//  BorderedView.swift
//  Advanced Calculator
//
//  Created by Esma on 9/20/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

class BorderedView: UIView {

   override func awakeFromNib() {
           super.awakeFromNib()
           setupview()
       }
       
       private func setupview(){
           self.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
           self.layer.borderWidth = 5
           
       }
       override func prepareForInterfaceBuilder() {
           setupview()
       }

}
