//
//  Grade.swift
//  MyCreditManager_2_wnsdyds403
//
//  Created by 지준용 on 2023/08/14.
//

import Foundation

enum Grade: String {
    case Aplus = "A+"
    case Azero = "A0"
    case Bplus = "B+"
    case Bzero = "B0"
    case Cplus = "C+"
    case Czero = "C0"
    case Dplus = "D+"
    case Dzero = "D0"
    case F = "F"
    
    static func calculateScore(_ grade: Grade) -> Double {
        switch grade {
        case .Aplus: return 4.5
        case .Azero: return 4.0
        case .Bplus: return 3.5
        case .Bzero: return 3.0
        case .Cplus: return 2.5
        case .Czero: return 2.0
        case .Dplus: return 1.5
        case .Dzero: return 1.0
        default: return 0.0
        }
    }
}
