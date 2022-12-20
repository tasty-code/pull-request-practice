//
//  StudentList.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

class StudentList {
    private var students = [Student]()
    private let key = "students"

    init() {
        loadData()
    }

    func addStudent(name: String) {
        guard students.contains(where: { $0.name == name }) == false else { return ConsoleView.printStudentAlreadyExists(name: name) }

        students.append(Student(name: name))
        ConsoleView.printAddStudentComplete(name: name)
    }

    func removeStudent(name: String) {
        guard let index = students.firstIndex(where: { $0.name == name }) else { return ConsoleView.printStudentNotFound(name: name) }

        students.remove(at: index)
        ConsoleView.printRemoveStudentComplete(name: name)
    }

    func updateScore(studentName: String, subject: Subject) {
        guard let student = students.first(where: { $0.name == studentName }) else { return ConsoleView.printStudentNotFound(name: studentName) }

        student.updateScore(subject: subject)
        ConsoleView.printUpdateScoreComplete(studentName: studentName, subjectName: subject.name, grade: subject.getGrade().description)
    }

    func removeScore(studentName: String, subjectName: String) {
        guard let student = students.first(where: { $0.name == studentName }) else { return ConsoleView.printStudentNotFound(name: studentName) }

        let isCompleted = student.removeScore(subjectName: subjectName)

        if isCompleted {
            ConsoleView.printRemoveScoreComplete(studentName: studentName, subjectName: subjectName)
        }
    }

    func showAverageScore(studentName: String) {
        guard let student = students.first(where: { $0.name == studentName }) else { return ConsoleView.printStudentNotFound(name: studentName) }
        student.showAverageScore()
    }

    func saveData() {
        let value = try? PropertyListEncoder().encode(students)
        UserDefaults.standard.setValue(value, forKey: key)
        ConsoleView.printSaveDataInform()
    }

    func loadData() {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return }
        guard let loadStudents = try? PropertyListDecoder().decode([Student].self, from: data) else { return }

        if loadStudents.isEmpty == false {
            students = loadStudents
            ConsoleView.printLoadDataInform()
        }
    }
}
