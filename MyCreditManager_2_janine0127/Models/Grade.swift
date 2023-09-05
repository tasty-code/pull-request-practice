//
//  grade.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/20.
//

import Foundation

class Grade : Codable {
    let subject: String
    var value: LetterGrade
    
    init(subject: String, value: LetterGrade) {
        self.subject = subject
        self.value = value
    }
    
    func updateGrade(_ newVal: LetterGrade) {
        self.value = newVal
    }
}
