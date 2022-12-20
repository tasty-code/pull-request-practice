//
//  Grade.swift
//  StudentGradeManager
//
//  Created by 조용현 on 2022/12/20.
//

import Foundation

enum Grade: Double {
    case APlus = 4.5
    case AZero = 4.0
    case BPlus = 3.5
    case BZero = 3.0
    case CPlus = 2.5
    case CZero = 2.0
    case DPlus = 1.5
    case DZero = 1.0
    case F = 0.0
    
    static func gradeForString(for gradeString: String) throws -> Grade {
        switch gradeString {
        case "A+":
            return Grade.APlus
        case "A0":
            return Grade.AZero
        case "B+":
            return Grade.BPlus
        case "B0":
            return Grade.BZero
        case "C+":
            return Grade.CPlus
        case "C0":
            return Grade.CZero
        case "D+":
            return Grade.DPlus
        case "D0":
            return Grade.DZero
        case "F":
            return Grade.F
        default:
            throw InputError.invalidInput
        }
    }
    
    static func printGradeString(for grade: Grade) {
        switch grade {
        case .APlus:
            print("A+")
        case .AZero:
            print("A0")
        case .BPlus:
            print("B+")
        case .BZero:
            print("B0")
        case .CPlus:
            print("C+")
        case .CZero:
            print("C0")
        case .DPlus:
            print("D+")
        case .DZero:
            print("D0")
        case .F:
            print("F")
        }
    }
}
