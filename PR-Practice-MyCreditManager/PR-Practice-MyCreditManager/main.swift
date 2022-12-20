//
//  main.swift
//  PR-Practice-MyCreditManager
//
//  Created by devxsby on 2022/12/20.
//

import Foundation


class MyCreditManager {
    
    private var studentDictionary = [String : Student]()
    var runValue: Bool = true

    func showMenu() {
        print(StringLiterals.Menu.startProgram)
    }
    
    func getUserInput() {
        
        // TODO: - 영어와 + 문자만 받아오도록 하기
        
        guard let input = readLine() else { return }
        selectMenu(input: input)
    }
    
    private func printWrongMenuError() {
        print(StringLiterals.Menu.wrongMenu)
    }
    
    private func printInputError() {
        print(StringLiterals.Menu.wrongInput)
    }
    
    private func selectMenu(input: String) {
        let menu = Menu(rawValue: input)
        switch menu {
        case .addStudent:
            addStudentProgram()
        case .deleteStudent:
            deleteStudentProgram()
        case .addOrChangeGrades:
            addOrChangeGradesProgram()
        case .deleteGrades:
            deleteGradesProgram()
        case .showGrades:
            showGradesProgram()
        case .exitProgram:
            exitProgram()
        default:
            printWrongMenuError()
        }
    }
    
    private func isExistStudent(_ name: String) -> Bool {
        if let _ = studentDictionary[name] {
            return true
        } else {
            return false
        }
    }
    
    private func isExistSubject(name: String, subject: String) -> Bool {
        if let student = studentDictionary[name] {
            if let _ = student.grades[subject] {
                return true
            }
        }
        return false
    }
        
    private func addStudentProgram() {
        print(StringLiterals.Student.addStudentMessage)
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            print("\(name)\(StringLiterals.Student.alredyExistError)")
        } else {
            studentDictionary[name] = Student(name: name)
            print(name, StringLiterals.Student.addStudentSuccess)
        }
    }
    
    private func deleteStudentProgram() {
        print(StringLiterals.Student.deleteStudentMessage)
        
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            studentDictionary.removeValue(forKey: name)
            print(name, StringLiterals.Student.deleteStudentSuccess)
        } else {
            print(name, StringLiterals.Student.nonExistError)
        }
    }
    
    private func addOrChangeGradesProgram() {
        print(StringLiterals.Grades.addOrChangeGradesMessage)
        
        let input = readLine()!.split(separator: " ").map { String($0) }
        
        if input.count != 3 || !isExistStudent(input[0]) {
            
            // TODO: - 과목 a+, b+ 등 만 추가되게 하기
            
            printInputError()
            return
        }
        
        let (name, subject, score) = (input[0], input[1], input[2])
        
        if let student = studentDictionary[name] {
            student.grades[subject] = score
            print(name, StringLiterals.Grades.studentSuccess,
                  subject, StringLiterals.Grades.subjectSuccess,
                  "\(score)\(StringLiterals.Grades.scoreSuccess)")
        } else {
            print(name,StringLiterals.Student.nonExistError)
        }
    }
    
    private func deleteGradesProgram() {
        print(StringLiterals.Grades.deleteGradesMessage)
        
        let input = readLine()!.split(separator: " ").map { String($0) }
        
        if input.count != 2 || !isExistStudent(input[0]) {
            printInputError()
            return
        }
        
        let (name, subject) = (input[0], input[1])
        
        // TODO: - 사람 있고 과목이 없는 경우는 에러띄우기
        
        if let student = studentDictionary[name] {
            student.grades.removeValue(forKey: subject)
            print(name, StringLiterals.Grades.studentSuccess,
                  subject, StringLiterals.Grades.deleteSuccess)
        } else {
            print(name,StringLiterals.Student.nonExistError)
        }
    }
    
    private func showGradesProgram() {
        print(StringLiterals.Grades.showGradesMessage)
        
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            if let student = studentDictionary[name] {
                
                // TODO: - 사람 있고 과목이 없는 경우는 에러띄우기

                for grade in student.grades {
                    print("\(grade.key): \(grade.value)")
                }
                
                // TODO: - 평점 구현하기 최대 소수점 2자리 ex) 4, 3.75, 4.1

            }
        } else {
            print(name, StringLiterals.Student.nonExistError)
        }
    }
    
    private func exitProgram() {
        print(StringLiterals.Menu.exitProgram)
        runValue = false
        // TODO: - 저장 기능 추가하기
    }
}

func main() {
    
    let myCreditManager = MyCreditManager()
    
    while myCreditManager.runValue {
        myCreditManager.showMenu()
        myCreditManager.getUserInput()
    }
}

main()
