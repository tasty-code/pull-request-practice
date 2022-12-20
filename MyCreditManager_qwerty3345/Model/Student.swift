//
//  Student.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

class Student: Codable {
    let name: String
    private var subjects = [Subject]()

    init(name: String) {
        self.name = name
    }

    func updateScore(subject: Subject) {
        if let index = subjects.firstIndex(where: { $0.name == name }) {
            subjects[index] = subject
        } else {
            subjects.append(subject)
        }
    }

    func removeScore(subjectName: String) -> Bool {
        if let index = subjects.firstIndex(where: { $0.name == subjectName }) {
            subjects.remove(at: index)
            return true
        } else {
            ConsoleView.printSubjectNotFound(subjectName: subjectName)
            return false
        }
    }

    func showAverageScore() {
        subjects.forEach { subject in
            print("\(subject.name): \(subject.grade.description)")
        }

        let average = subjects.reduce(0.0) { result, subject in
            return result + subject.grade.rawValue
        } / Double(subjects.count)

        print("평점 : \(average)")
    }
}
