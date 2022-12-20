//
//  Student.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

import Foundation

final class System {
    private var students: [Student]

    init() {
        self.students = []
    }

    // 명렁어 - 학생추가 구현부
    func addStudent() -> State {
        // 설명 안내 문구 출력, 추가할 학생의 이름을 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameToAdd) else {
            return .quit
        }
        // 이름 유효성 검사
        guard checkValidInput(studentName) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 이미 존재하는 이름은 사용할 수 없음
        if let index = findStudentIndex(name: studentName) {
            print(self.students[index].name, terminator: "")
            Message.cannotAddStudentAlreadyExistName.printSelf()
            return .continued
        }
        self.students.append(Student(name: studentName))
        print(studentName, terminator: " ")
        Message.addedStudent.printSelf()
        return .continued
    }

    // 명렁어 - 학생삭제 구현부
    func deleteStudent() -> State {
        // 설명 안내 문구 출력, 삭제할 학생의 이름을 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameToDelete) else {
            return .quit
        }
        // 이름 유효성 검사
        guard checkValidInput(studentName) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 존재하지 않는 학생은 삭제할 수 없음
        guard let index = findStudentIndex(name: studentName) else {
            print(studentName, terminator: " ")
            Message.cannotFindStudent.printSelf()
            return .continued
        }
        // 성적 모두 삭제
        self.students[index].grades.removeAll()
        // 학생 삭제
        self.students = self.students.filter { $0.name != students[index].name }
        print(studentName, terminator: " ")
        Message.deletedStudent.printSelf()
        return .continued
    }

    // 명렁어 - 성적추가(변경) 구현부
    func updateGrade() -> State {
        // 설명 안내 문구 출력, 성적추가할 학생이름, 과목이름, 성적 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let input = getLine(messageType: .pleaseInputNameAndGradeToUpdate) else {
            return .quit
        }
        // 입력값이 " "를 기준으로 학생, 과목, 성적으로 나뉘는지 체크
        guard let inputs = getSplittedInput(input, count: 3) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 학생이 존재하는지 확인
        guard let index = findStudentIndex(name: inputs[0]) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 성적이 "A+" ~ "F"로 유효한지 확인
        guard let grade = Grade(rawValue: inputs[2]) else {
            Message.inputError.printSelf()
            return .continued
        }
        self.students[index].grades[inputs[1]] = grade
        return .continued
    }

    // 명렁어 - 성적삭제 구현부
    func deleteGrade() -> State {
        // 설명 안내 문구 출력, 성적추가할 학생이름, 과목이름, 성적 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let input = getLine(messageType: .pleaseInputNameAndSubjectToDelete) else {
            return .quit
        }
        // 입력값이 " "를 기준으로 학생, 과목으로 나뉘는지 체크
        guard let inputs = getSplittedInput(input, count: 2) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 학생이 존재하지 않는 경우
        guard let index = findStudentIndex(name: inputs[0]) else {
            Message.cannotFindStudent.printSelf()
            return .continued
        }
        // 성적이 존재하지 않는 경우
        guard self.students[index].grades[inputs[1]] != nil else {
            Message.inputError.printSelf()
            return .continued
        }
        print("\(self.students[index].name) 학생의 \(inputs[1])", terminator: " ")
        self.students[index].grades[inputs[1]] = nil
        Message.deletedGrade.printSelf()
        return .continued
    }

    // 명렁어 - 평점보기 구현부
    func showGPA() -> State {
        // 설명 안내 문구 출력, 평점을 보고 싶은 학생의 이름 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameWantToShowGPA) else {
            return .quit
        }
        // 이름 유효성 검사
        guard checkValidInput(studentName) else {
            Message.inputError.printSelf()
            return .continued
        }
        // 존재하지 않는 학생의 평점은 볼 수 없음
        guard let index = findStudentIndex(name: studentName) else {
            print(studentName, terminator: " ")
            Message.cannotFindStudent.printSelf()
            return .continued
        }
        // 성적이 존재하지 않는 경우
        guard !self.students[index].grades.isEmpty else {
            Message.notExistGrade.printSelf()
            return .continued
        }
        // 과목 및 성적 출력
        // 점수 합 계산
        for (subject, grade) in self.students[index].grades {
            print("\(subject): \(grade.rawValue)")
        }
        // 성적 합
        let scoreSum = self.students[index].grades.compactMap { $0.value.gradeToScore() }.reduce(0, +)
        // 평점 소숫점 두자리까지 출력
        print("평점 :", calculateGPA(scoreSum: scoreSum, count: self.students[index].grades.count))
        return .continued
    }

    // 명렁어 - 종료 구현부
    func quit() -> State {
        return .quit
    }

    // 이름으로 학생이 존재하는지 확인 후 인덱스 반환
    func findStudentIndex(name: String) -> Int? {
        for (index, student) in students.enumerated() where student.name == name {
            return index
        }
        return nil
    }

    // 입력값 유효성 검사
    func checkValidInput(_ name: String) -> Bool {
        // ""은 유효하지 않은 입력
        guard !name.isEmpty else {
            return false
        }
        // 한글 및 다른 문자 체계는 이름으로 사용할 수 없음
        guard name.filter({$0.isASCII && $0 != "\0"}).count == name.count else {
            return false
        }
        return true
    }

    // 성적추가, 성적삭제 관련 Split 함수
    func getSplittedInput(_ input: String, count: Int) -> [String]? {
        // 이름 유효성 검사
        guard checkValidInput(input) else {
            return nil
        }
        // 입력이 count수만큼 나눠지는지 확인
        let inputs = input.components(separatedBy: " ")
        guard inputs.count == count else {
            return nil
        }
        return inputs
    }
}
