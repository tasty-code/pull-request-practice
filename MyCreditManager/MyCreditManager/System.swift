//
//  Student.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

final class System {
    private var students: [Student]

    // TODO: 생성자 호출시 외부 파일로부터 학생정보 읽어오기
    init() {
        self.students = []
    }

    func addStudent() -> State {
        // 설명 안내 문구 출력, 추가할 학생의 이름을 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameToAdd) else {
            return .quit
        }
        // 이름 유효성 검사
        if !checkValidName(studentName) {
            printMessage(messageType: .inputError)
            return .run
        }
        // 이미 존재하는 이름은 사용할 수 없음
        if let index = findStudentIndex(name: studentName) {
            print(self.students[index].name, terminator: "")
            printMessage(messageType: .cannotAddStudentAlreadyExistName)
            return .run
        }
        self.students.append(Student(name: studentName))
        print(studentName, terminator: " ")
        printMessage(messageType: .addedStudent)
        return .run
    }

    func deleteStudent() -> State {
        // 설명 안내 문구 출력, 삭제할 학생의 이름을 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameToDelete) else {
            return .quit
        }
        // 이름 유효성 검사
        if !checkValidName(studentName) {
            printMessage(messageType: .inputError)
            return .run
        }
        // 존재하지 않는 학생은 삭제할 수 없음
        guard let index = findStudentIndex(name: studentName) else {
            print(studentName, terminator: " ")
            printMessage(messageType: .cannotFindStudent)
            return .run
        }
        self.students = self.students.filter { $0.name != students[index].name }
        print(studentName, terminator: " ")
        printMessage(messageType: .deletedStudent)
        return .run
    }

    func updateGrade() -> State {
        // 설명 안내 문구 출력, 성적추가할 학생이름, 과목이름, 성적 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let input = getLine(messageType: .pleaseInputNameAndGradeToUpdate) else {
            return .quit
        }
        guard let inputs = getSplittedInput(input) else {
            printMessage(messageType: .inputError)
            return .run
        }
        guard let index = findStudentIndex(name: inputs[0]) else {
            printMessage(messageType: .inputError)
            return .run
        }
        guard let grade = Grade(rawValue: inputs[2]) else {
            printMessage(messageType: .inputError)
            return .run
        }
        self.students[index].grades[inputs[1]] = grade
        return .run
    }

    func findStudentIndex(name: String) -> Int? {
        for (index, student) in students.enumerated() where student.name == name {
            return index
        }
        return nil
    }

    func checkValidName(_ name: String) -> Bool {
        // ""은 이름으로 사용할 수 없음
        guard !name.isEmpty else {
            return false
        }
        // 한글 및 다른 문자 체계는 이름으로 사용할 수 없음
        guard name.filter({$0.isASCII && $0 != "\0"}).count == name.count else {
            return false
        }
        return true
    }

    func getSplittedInput(_ input: String) -> [String]? {
        // 이름 유효성 검사
        guard checkValidName(input) else {
            return nil
        }
        // 입력이 3부분으로 나눠지는지 확인
        let inputs = input.components(separatedBy: " ")
        guard inputs.count == 3 else {
            return nil
        }
        return inputs
    }
}
