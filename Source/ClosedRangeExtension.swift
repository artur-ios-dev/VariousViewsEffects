//
//  ClosedRangeExtension.swift
//  Demo
//
//  Created by Artur Rymarz on 20.04.2018.
//  Copyright © 2018 Artrmz. All rights reserved.
//

import Foundation

extension ClosedRange where Bound: FloatingPoint {
    func random() -> Bound {
        let max = UInt32.max
        return
            Bound(arc4random_uniform(max)) /
                Bound(max) *
                (upperBound - lowerBound) +
        lowerBound
    }
}
