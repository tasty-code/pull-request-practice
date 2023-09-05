//
//  LetterGrade.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/21.
//

import Foundation

enum LetterGrade: String,Codable {
    case APlus = "A+"
    case A = "A"
    case BPlus = "B+"
    case B = "B"
    case CPlus = "C+"
    case C = "C"
    case DPlus = "D+"
    case D = "D"
    case F = "F"
    
    var point: Double {
        switch self {
        case .APlus:
            return 4.5
        case .A:
            return 4.0
        case .BPlus:
            return 3.5
        case .B:
            return 3.0
        case .CPlus:
            return 2.5
        case .C:
            return 2.0
        case .DPlus:
            return 1.5
        case .D:
            return 1.0
        case .F:
            return 0.0
        }
    }
}

