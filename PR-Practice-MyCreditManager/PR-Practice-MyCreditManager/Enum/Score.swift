//
//  Score.swift
//  PR-Practice-MyCreditManager
//
//  Created by devxsby on 2022/12/20.
//

import Foundation

enum Score: String {
    case aPlus = "A+"
    case aZero = "A0"
    case bPlus = "B+"
    case bZero = "B0"
    case cPlus = "C+"
    case cZero = "C0"
    case dPlus = "D+"
    case dZero = "D0"
    case fail = "F"
    
    func toDouble() -> Double {
        switch self {
        case .aPlus:
            return 4.5
        case .aZero:
            return 4.0
        case .bPlus:
            return 3.5
        case .bZero:
            return 3.0
        case .cPlus:
            return 2.5
        case .cZero:
            return 2.0
        case .dPlus:
            return 1.5
        case .dZero:
            return 1.0
        case .fail:
            return 0
        }
    }
}
