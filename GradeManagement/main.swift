//
//  main.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

var input = String()

func inputCommand() -> String? {
    return readLine()
}

var manager = Management().students
repeat {
    print(Questions.main.rawValue)
    guard let input = inputCommand() else { break }
    switch Commands(rawValue: input) {
    case .addStudent:
        addStudent()
    case .deleteStudent:
        deleteStudent()
    case .updateGrade:
        updateGrade()
    case .removeGrade:
        removeGrade()
    case .reportCard:
        reportCard()
    default:
        print(Errors.main.rawValue)
    }
} while input != Commands.exit.rawValue

