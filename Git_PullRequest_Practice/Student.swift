//
//  Student.swift
//  Git_ Exercise
//
//  Created by 송선화 on 2022/12/19.
//

import Foundation
import RealmSwift

class Student: Object {
    @Persisted var name: String = ""
    // realm에서는 Swift의 Array 사용하지 못하므로, List 사용
    @Persisted var grade: List<Grade> = List<Grade>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class Grade: Object {
    @Persisted var subject: String
    @Persisted var score: Score
    
    convenience init(subject: String, score: Score) {
        self.init()
        self.subject = subject
        self.score = score
    }
}

enum Score: String, PersistableEnum {
    case A = "A+"
    case A0 = "A0"
    case B = "B+"
    case B0 = "B0"
    case C = "C+"
    case C0 = "C0"
    case D = "D+"
    case D0 = "D0"
    case F = "F"
    
    var numScore: Double {
        switch self {
        case .A:
            return 4.5
        case .A0:
            return 4.0
        case .B:
            return 3.5
        case .B0:
            return 3.0
        case .C:
            return 2.5
        case .C0:
            return 2.0
        case .D:
            return 1.5
        case .D0:
            return 1.0
        case .F:
            return 0
        }
    }
}
