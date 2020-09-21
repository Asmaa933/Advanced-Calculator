//
//  Extensions.swift
//  Advanced Calculator
//
//  Created by Esma on 9/21/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import Foundation

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
