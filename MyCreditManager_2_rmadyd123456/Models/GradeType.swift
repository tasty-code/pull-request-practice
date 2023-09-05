//
//  GradeModel.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/14.
//

import Foundation

@frozen enum GradeType: CaseIterable, Codable {
    case aPlus, a, bPlus, b, cPlus, c, dPlus, d, f
    
    var score: Double {
        switch self {
        case .aPlus: return 4.5
        case .a: return 4.0
        case .bPlus: return 3.5
        case .b: return 3.0
        case .cPlus: return 2.5
        case .c: return 2.0
        case .dPlus: return 1.5
        case .d: return 1.0
        case .f: return 0
        }
    }
    
    var rawValue: String {
        switch self {
        case .aPlus: return "A+"
        case .a: return "A0"
        case .bPlus: return "B+"
        case .b: return "B0"
        case .cPlus: return "C+"
        case .c: return "C0"
        case .dPlus: return "D+"
        case .d: return "D0"
        case .f: return "F"
        }
    }
}
