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

extension Command {
    func execute() -> State {
        switch self {
        case .addStudent: return system.addStudent()
        case .deleteStudent: return system.deleteStudent()
        case .updateGrade: return system.updateGrade()
        case .deleteGrade: return system.deleteGrade()
        case .showGPA: return system.showGPA()
        case .quitProgram: return system.quit()
        }
    }
}
