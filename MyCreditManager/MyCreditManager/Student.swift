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
