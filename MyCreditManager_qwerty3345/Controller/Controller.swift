//
//  Controller.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

class Controller {
    private let studentList = StudentList()

    func userSelectMenu() -> Bool {
        ConsoleView.printUserSelectMenu()
        let input = ConsoleView.userInput()

        if input.lowercased() == "x" {
            saveData()
            ConsoleView.printTerminateProgram()
            return false
        }

        guard InputChecker.checkUserSelectMenuInput(input: input) else {
            ConsoleView.printUserSelectMenuError()
            return true
        }

        switch input {
        case "1":
            addStudent()
        case "2":
            removeStudent()
        case "3":
            updateScore()
        case "4":
            removeScore()
        case "5":
            showAverageScore()
        default:
            break
        }

        return true
    }

    func addStudent() {
        ConsoleView.printAddStudentInform()
        let input = ConsoleView.userInput()
        guard input.isEmpty == false else { return ConsoleView.printInputError() }
        studentList.addStudent(name: input)
    }

    func removeStudent() {
        ConsoleView.printRemoveStudentInform()
        let input = ConsoleView.userInput()
        guard input.isEmpty == false else { return ConsoleView.printInputError() }
        studentList.removeStudent(name: input)
    }

    func updateScore() {
        ConsoleView.printUpdateScoreInform()
        let input = ConsoleView.userInput()
        guard InputChecker.checkUpdateScoreInput(input: input) else { return ConsoleView.printInputError() }

        let array = input.split(separator: " ")
        let studentName = String(array[0])
        let subjectName = String(array[1])
        guard let grade = Grade(string: String(array[2])) else { return ConsoleView.printInputError() }

        studentList.updateScore(studentName: studentName, subject: Subject(name: subjectName, grade: grade))
    }

    func removeScore() {
        ConsoleView.printRemoveScoreInform()
        let input = ConsoleView.userInput()
        guard InputChecker.checkRemoveScoreInput(input: input) else { return ConsoleView.printInputError() }

        let array = input.split(separator: " ")
        let studentName = String(array[0])
        let subjectName = String(array[1])

        studentList.removeScore(studentName: studentName, subjectName: subjectName)
    }

    func showAverageScore() {
        ConsoleView.printShowScoreInform()
        let input = ConsoleView.userInput()

        studentList.showAverageScore(studentName: input)
    }

    func saveData() {
        studentList.saveData()
    }
}
