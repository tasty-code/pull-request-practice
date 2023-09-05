//
//  Grade.swift
//  MyCreditManager_2_kbs96117
//
//  Created by BOMBSGIE on 2023/08/18.
//

import Foundation

enum Grade: String, Codable {
    
    case aPlus = "A+"
    case aZero = "A0"
    case bPlus = "B+"
    case bZero = "B0"
    case cPlus = "C+"
    case cZero = "C0"
    case dPlus = "D+"
    case dZero = "D0"
    case f = "F"
    
    var score: Double {
        switch self {
        case .aPlus: return 4.5
        case .aZero: return 4.0
        case .bPlus: return 3.5
        case .bZero: return 3.0
        case .cPlus: return 2.5
        case .cZero: return 2.0
        case .dPlus: return 1.5
        case .dZero: return 1.0
        case .f: return 0.0
        }
    }
}
