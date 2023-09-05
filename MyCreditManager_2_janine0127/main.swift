//
//  main.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/19.
//

import Foundation

var isOver = false
var manager = ServiceManager()
manager.loadData()

while !isOver {
    print(Alert.initial.message)

    let userInput = readLine()

    guard let choice = userInput else {
        print(Alert.failed.message)
        break
    }

    switch Menu(rawValue: choice) {
    case .studentAdder:
        manager.addStudent()
        break
    case .studentRemover:
        manager.removeStudent()
        break
    case .GradeUpdater:
        manager.addGrade()
        break
    case .GradeRemover:
        manager.removeGrade()
        break
    case .Average:
        manager.getGradeAll()
        break
    case .Exit, .ExitLowerCase:
        print(Alert.end.message)
        manager.saveData()
        isOver = true
        break
    default:
        print(Alert.failed.message)
        break
    }
}
