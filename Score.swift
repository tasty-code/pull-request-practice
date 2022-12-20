//
//  Score.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

enum Score: Float, Codable {
    case APlus = 4.5
    case A = 4
    case BPlus = 3.5
    case B = 3
    case CPlus = 2.5
    case C = 2
    case DPlus = 1.5
    case D = 1
    case F = 0
    
    var description: String {
        switch self {
        case .APlus:
            return "A+"
        case .A:
            return "A0"
        case .BPlus:
            return "B+"
        case .B:
            return "B0"
        case .CPlus:
            return "C+"
        case .C:
            return "C0"
        case .DPlus:
            return "D+"
        case .D:
            return "D0"
        case .F:
            return "F"
        }
    }
    
    init?(score: String) {
        switch score {
        case "A+", "a+", "4.5":
            self = .APlus
        case "A", "a", "A0", "a0", "4", "4.0":
            self = .A
        case "B+", "b+", "3.5":
            self = .BPlus
        case "B", "b", "B0", "b0", "3", "3.0":
            self = .B
        case "C+", "c+", "2.5":
            self = .CPlus
        case "C", "c", "C0", "c0", "2", "2.0":
            self = .C
        case "D+", "d+", "1.5":
            self = .DPlus
        case "D", "d", "D0", "d0", "1", "1.0":
            self = .D
        case "F", "f", "0", "0.0":
            self = .F
        default:
            return nil
        }
    }
}
