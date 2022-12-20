//
//  Command.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

enum Command: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case updateGrade = "3"
    case deleteGrade = "4"
    case showGPA = "5"
    case quitProgram = "X"
}

func executeCommand(_ command: Command) -> State {
    switch command {
    case .addStudent: return system.addStudent()
    case .deleteStudent: return system.deleteStudent()
    case .updateGrade: return system.updateGrade()
    case .deleteGrade: print("4: 성적삭제")
    case .showGPA: return system.showGPA()
    case .quitProgram: return .quit
    }
    return .run
}
