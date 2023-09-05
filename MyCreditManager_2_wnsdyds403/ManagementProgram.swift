//
//  ManagementProgram.swift
//  MyCreditManager_2_wnsdyds403
//
//  Created by 지준용 on 2023/08/14.
//

import Foundation

final class ManagementProgram {
    
    // MARK: - Property
    
    private let dataManager = DataManager()
    private var students = [String: [Student]]()
    
    func run() {
        loadData()
        showMenu()
    }

    private func showMenu() {
        while true {
            print(Guide.menus)
            guard let selectedMenu = readLine() else { return }

            if selectedMenu == "X" {
                return print(Guide.exit)
            }

            activateProgram(with: selectedMenu)
        }
    }
    
    private func activateProgram(with selectedMenu: String) {
        switch selectedMenu {
        case "1": addStudent()
        case "2": deleteStudent()
        case "3": addAndUpdateGrade()
        case "4": deleteGrade()
        case "5": return calculateAverage()
        default: return print("뭔가 \(Guide.reselectMenu)")
        }

        saveData()
    }
    
    // MARK: - 1.학생 추가
    
    private func addStudent() {
        print("추가할 \(Guide.studentName)")

        guard let name = readLine(), name.contains(where: { $0.isLetter }) else {
            return print(Guide.checkInput)
        }
        
        if students[name] != nil {
            return print("\(name)은 \(Guide.alreadyExistence)")
        }
        students[name] = []
        
        print("\(name) \(Guide.addedStudent)")
    }
    
    // MARK: - 2.학생 삭제
    
    private func deleteStudent() {
        print("삭제할 \(Guide.studentName)")

        guard let name = readLine(), !name.isEmpty else {
            return print(Guide.checkInput)
        }
        
        if students[name] == nil {
            return print("\(name) \(Guide.notFoundStudent)")
        }
        students[name] = nil

        print("\(name) \(Guide.deletedStudent)")
    }
    
    // MARK: - 3.성적 추가(변경)
    
    private func addAndUpdateGrade() {
        print(Guide.inputGrade)
        guard let input = readLine() else { return }
        let studentGrade = input.split(separator: " ").map { String($0) }
        
        if studentGrade.count != 3 {
            return print(Guide.checkInput)
        }
        
        guard let grade = Grade(rawValue: studentGrade[2])?.rawValue else {
            return print(Guide.checkInput)
        }
        let name = studentGrade[0]
        let subject = studentGrade[1]

        if students[name] == nil {
            return print("\(name) \(Guide.notFoundStudent)")
        }

        if let index = students[name]?.firstIndex(where: {$0.subject == subject} ) {
            students[name]?[index].grade = grade
        } else {
            students[name]?.append(Student(subject: subject, grade: grade))
        }
        
        print("\(name) 학생의 성적 중 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    }
    
    // MARK: - 4. 성적 삭제
    
    private func deleteGrade() {
        print(Guide.inputStudentNameAndSubject)
        
        guard let input = readLine() else { return }
        let studentSubject = input.split(separator: " ").map { String($0) }
        
        if studentSubject.count != 2 {
            return print(Guide.checkInput)
        }

        let name = studentSubject[0]
        let subject = studentSubject[1]

        if students[name] == nil {
            return print("\(name) \(Guide.notFoundStudent)")
        }

        guard let index = students[name]?.firstIndex(where: {$0.subject == subject} ) else {
            return print("\(name) 학생의 \(subject) 과목의 \(Guide.notFoundGrade)")
        }
        students[name]?.remove(at: index)

        print("\(name) 학생의 \(subject) 과목의 \(Guide.deletedGrade)")
    }

    // MARK: - 5. 평점 보기

    private func calculateAverage() {
        print("평점을 알고싶은 \(Guide.studentName)")

        guard let name = readLine(), !name.isEmpty else {
            return print(Guide.checkInput)
        }

        if students[name] == nil {
            return print("\(name) \(Guide.notFoundStudent)")
        }

        if students[name]!.isEmpty {
            return print("\(name) 학생의 \(Guide.notFoundGrade)")
        }

        var grades = [Double]()

        for i in 0..<students[name]!.count {
            let student = students[name]![i]
            
            guard let grade = Grade(rawValue: student.grade) else { return }
            grades.append(Grade.calculateScore(grade))
            
            print("\(student.subject): \(student.grade)")
        }

        let average = grades.reduce(0, +) / Double(grades.count)
        let roundedAvg = round(average * 100) / 100

        if roundedAvg > Double(Int(roundedAvg)) {
            return print("평점 : \(roundedAvg)")
        }
        print("평점 : \(Int(roundedAvg))")
    }
    
    // MARK: - Data Method
    
    private func loadData() {
        dataManager.loadData { students in
            self.students = students
        }
    }
    
    private func saveData() {
        dataManager.saveData(of: students)
    }
}
