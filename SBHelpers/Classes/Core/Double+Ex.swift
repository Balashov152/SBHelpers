//
//  Double+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 13.12.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import Foundation
public extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
