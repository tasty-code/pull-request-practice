//
//  Grade.swift
//  MyCreditManager_jasonLee0223
//
//  Created by Jason on 2022/12/08.
//

import Foundation

enum Grade: Double, CaseIterable, CustomStringConvertible {
    case APlus = 4.5
    case AZero = 4.0
    case BPlus = 3.5
    case BZero = 3.0
    case CPlus = 2.5
    case CZero = 2.0
    case DPlus = 1.5
    case DZero = 1
    case F = 0
    case Unknown = 100
    
    var description: String {
        switch self {
        case .APlus:
            return "A+"
        case .AZero:
            return "A0"
        case .BPlus:
            return "B+"
        case .BZero:
            return "B0"
        case .CPlus:
            return "C+"
        case .CZero:
            return "C0"
        case .DPlus:
            return "D+"
        case .DZero:
            return "D0"
        case .F:
            return "F"
        case .Unknown:
            return ""
        }
    }
}
