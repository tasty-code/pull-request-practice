//
//  DeleteStudent.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

func deleteStudent() {
    print(Questions.deleteStudent.rawValue)
    guard let student = readLine() else { return }
    guard let _ = student.range(of: Pattern.input.rawValue, options: .regularExpression),
          student.isEmpty == false else {
        print(Errors.input.rawValue)
        return
    }
    let isContain = manager.contains { $0.key == student }
    guard isContain else {
        print("\(student)\(Errors.searchStudent.rawValue)")
        return
    }
    manager.removeValue(forKey: student)
    Operations().deleteStudent(student)
}
