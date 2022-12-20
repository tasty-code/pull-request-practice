//
//  RemoveGrade.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

func removeGrade() {
    print(Questions.removeGrade.rawValue)
    guard let answer = readLine() else { return }
    var inputs = answer.components(separatedBy: " ")
    guard 2 == inputs.count else {
        print(Errors.input.rawValue)
        return
    }
    for input in inputs {
        guard let _ = input.range(of: Pattern.input.rawValue, options: .regularExpression),
              input.isEmpty == false else {
            print(Errors.input.rawValue)
            return
        }
    }
    let student = inputs.removeFirst()
    let isStudent = manager.contains { $0.key == student }
    guard isStudent else {
        print("\(student)\(Errors.searchStudent.rawValue)")
        return
    }
    let subject = inputs.removeFirst()
    guard let reports = manager[student] else {return}
    for index in 0..<reports.count {
        if reports[index].subject == subject {
            manager[student]?.remove(at: index)
            Operations().removeGrade(subject, of: student)
            return
        }
    }
    print("\(subject) \(Errors.searchSubject.rawValue)")
}
