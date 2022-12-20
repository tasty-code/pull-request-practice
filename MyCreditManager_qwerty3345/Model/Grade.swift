//
//  Score.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

enum Grade: Double, Codable {
    case Aplus = 4.5
    case A0 = 4
    case Bplus = 3.5
    case B0 = 3
    case Cplus = 2.5
    case C0 = 2
    case Dplus = 1.5
    case D0 = 1
    case F = 0

    var description: String {
        switch self {
        case .Aplus:
            return "A+"
        case .A0:
            return "A0"
        case .Bplus:
            return "B+"
        case .B0:
            return "B0"
        case .Cplus:
            return "C+"
        case .C0:
            return "C0"
        case .Dplus:
            return "D+"
        case .D0:
            return "D0"
        case .F:
            return "F"
        }
    }

    init?(string: String) {
        switch string {
        case "A+":
            self = .Aplus
        case "A0", "A":
            self = .A0
        case "B+":
            self = .Bplus
        case "B0", "B":
            self = .B0
        case "C+":
            self = .Cplus
        case "C0", "C":
            self = .C0
        case "D+":
            self = .Dplus
        case "D0", "D":
            self = .D0
        case "F":
            self = .F
        default:
            return nil
        }
    }
}
