//
//  Margin.swift
//  Spielebuch
//
//  Created by Benno Kress on 12.06.19.
//  Copyright © 2019 Benno Kress. All rights reserved.
//

import Foundation
import SnapKit

enum Margin {
    case horizontal
    case vertical
    
    private var standardValue: Float {
        switch self {
        case .horizontal: return 16
        case .vertical: return 8
        }
    }
    
    /// To use with SnapKit when defining the offset for a top or leading margin.
    var standard: ConstraintOffsetTarget {
        switch self {
        case .horizontal: return standardValue
        case .vertical: return standardValue
        }
    }
    
    /// To use with SnapKit when defining the offset for a bottom or trailing margin.
    var inverseStandard: ConstraintOffsetTarget {
        switch self {
        case .horizontal: return -standardValue
        case .vertical: return -standardValue
        }
    }
}
