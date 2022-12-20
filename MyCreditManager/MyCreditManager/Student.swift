//
//  Student.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

typealias Subject = String

enum Grade: String {
    case aPlus = "A+"
    case aZero = "A0"
    case bPlus = "B+"
    case bZero = "B0"
    case cPlus = "C+"
    case cZero = "C0"
    case dPlus = "D+"
    case dZero = "D0"
    case fail = "F"
}

struct Student {
    let name: String
    var grades: [Subject: Grade]

    init(name: String) {
        self.name = name
        self.grades = [:]
    }
}

extension Grade {
    // 성적을 점수로 변환
    func gradeToScore() -> Double {
        switch self {
        case .aPlus: return 4.5
        case .aZero: return 4.0
        case .bPlus: return 3.5
        case .bZero: return 3.0
        case .cPlus: return 2.5
        case .cZero: return 2.0
        case .dPlus: return 1.5
        case .dZero: return 1.0
        case .fail: return 0.0
        }
    }
}

// 평균점수 계산, 최대소수점 2자리까지만 유효하도록
func calculateGPA(scoreSum: Double, count: Int) -> Double {
    let GPA: Double = round(scoreSum * 100.0 / Double(count)) / 100.0
    return GPA
}
