//
//  UpdateGrade.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

func updateGrade() {
    print(Questions.updateGrade.rawValue)
    guard let answer = readLine() else { return }
    var inputs = answer.components(separatedBy: " ")
    guard 3 == inputs.count else {
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
    
    let grade = inputs.removeLast()
    var score = ""
    switch Grade(rawValue: grade) {
    case .APlus:
        score = grade
    case .AZero:
        score = grade
    case .BPlus:
        score = grade
    case .BZero:
        score = grade
    case .CPlus:
        score = grade
    case .CZero:
        score = grade
    case .DPlus:
        score = grade
    case .DZero:
        score = grade
    case .F:
        score = grade
    default:
        print(Errors.input.rawValue)
        return
    }
    
    let subject = inputs.removeFirst()
    guard let reports = manager[student] else {return}
    for index in 0..<reports.count {
        if reports[index].subject == subject {
            manager[student]?.remove(at: index)
        }
    }
    let report = ReportCard(subject: subject, grade: score)
    manager[student]?.append(report)
    Operations().updateGrade(report, of: student)
}
