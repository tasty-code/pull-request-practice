//
//  Student.swift
//  StudentGradeManager
//
//  Created by 조용현 on 2022/12/20.
//

import Foundation

struct Student {
    
    var name: String
    var gradeForSubject: [String: Grade]
    
    init(name: String) {
        self.name = ""
        self.gradeForSubject = [:]
    }
    
    mutating func updateGrade(for subjuct: String, as grade: String) {
        
        do {
            gradeForSubject[subjuct] = try Grade.gradeForString(for: grade)
        } catch {
            print(InputError.invalidInput)
        }
    }
    
    mutating func deleteGrade(for subject: String) {
        gradeForSubject[subject] = nil
    }
    
    func printAllGrades() {
        for grade in gradeForSubject {
            print(grade.key, terminator: ": ")
            Grade.printGradeString(for: grade.value)
        }
    }
    
    func calculateAverageScore() throws -> Double {
        guard gradeForSubject.count != 0 else {
            throw InputError.emptyGrades
        }
        
        let averageGrade = gradeForSubject.values
            .map{ $0.rawValue }
            .reduce(0.0, +) / Double(gradeForSubject.count)
        
        return averageGrade
    }
}
