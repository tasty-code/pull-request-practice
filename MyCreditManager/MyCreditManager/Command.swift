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
    case .addStudent: print("1: 학생추가")
    case .deleteStudent: print("2: 학생삭제")
    case .updateGrade: print("3: 성적추가(변경)")
    case .deleteGrade: print("4: 성적삭제")
    case .showGPA: print("5: 평점보기")
    case .quitProgram: return .quit
    }
    return .run
}
