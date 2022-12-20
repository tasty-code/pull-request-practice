//
//  Subject.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

class Subject: Codable {
    let name: String
    let grade: Grade

    init(name: String, grade: Grade) {
        self.name = name
        self.grade = grade
    }

    func getGrade() -> Grade {
        return grade
    }


}
