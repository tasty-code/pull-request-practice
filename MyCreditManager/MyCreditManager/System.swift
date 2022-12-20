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
        guard let inputs = getSplittedInput(input, count: 3) else {
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

    func deleteGrade() -> State {
        // 설명 안내 문구 출력, 성적추가할 학생이름, 과목이름, 성적 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let input = getLine(messageType: .pleaseInputNameAndSubjectToDelete) else {
            return .quit
        }
        // " "을 기준으로 나눴을 때 배열의 크기가 2인지 확인
        guard let inputs = getSplittedInput(input, count: 2) else {
            printMessage(messageType: .inputError)
            return .run
        }
        // 학생이 존재하지 않는 경우
        guard let index = findStudentIndex(name: inputs[0]) else {
            printMessage(messageType: .cannotFindStudent)
            return .run
        }
        // 성적이 존재하지 않는 경우
        guard self.students[index].grades[inputs[1]] != nil else {
            printMessage(messageType: .inputError)
            return .run
        }
        print("\(self.students[index].name) 학생의 \(inputs[1])", terminator: " ")
        self.students[index].grades[inputs[1]] = nil
        printMessage(messageType: .deletedGrade)
        return .run
    }

    func showGPA() -> State {
        // 설명 안내 문구 출력, 평점을 보고 싶은 학생의 이름 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameWantToShowGPA) else {
            return .quit
        }
        // 이름 유효성 검사
        if !checkValidName(studentName) {
            printMessage(messageType: .inputError)
            return .run
        }
        // 존재하지 않는 학생의 평점은 볼 수 없음
        guard let index = findStudentIndex(name: studentName) else {
            print(studentName, terminator: " ")
            printMessage(messageType: .cannotFindStudent)
            return .run
        }
        // 성적이 존재하지 않는 경우
        if self.students[index].grades.isEmpty {
            printMessage(messageType: .notExistGrade)
            return .run
        }
        // 과목 및 성적 출력
        // 점수 합 계산
        for (subject, grade) in self.students[index].grades {
            print("\(subject): \(grade.rawValue)")
        }
        let scoreSum = self.students[index].grades.compactMap {gradeToScore(grade: $0.value)}.reduce(0, +)
        // 평점 소숫점 두자리까지 출력
        print("평점 :", calculateGPA(scoreSum: scoreSum, count: self.students[index].grades.count))
        return .run
    }

    func findStudentIndex(name: String) -> Int? {
        for (index, student) in students.enumerated() where student.name == name {
            return index
        }
        return nil
    }

    // TODO: getLine()으로 통합시키기 고려, eof와 "", NON_ASCII 다르게 처리하는 것 고려
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

    func getSplittedInput(_ input: String, count: Int) -> [String]? {
        // 이름 유효성 검사
        guard checkValidName(input) else {
            return nil
        }
        // 입력이 3부분으로 나눠지는지 확인
        let inputs = input.components(separatedBy: " ")
        guard inputs.count == count else {
            return nil
        }
        return inputs
    }
}
