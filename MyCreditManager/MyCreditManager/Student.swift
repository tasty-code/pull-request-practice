//
//  Student.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

final class Student {
    var names: [String]

    // TODO: 생성자 호출시 외부 파일로부터 학생정보 읽어오기
    init() {
        self.names = []
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
        if self.names.contains(studentName) {
            print(studentName, terminator: "")
            printMessage(messageType: .cannotAddStudentAlreadyExistName)
            return .run
        }
        self.names.append(studentName)
        print(studentName, terminator: " ")
        printMessage(messageType: .addedStudent)
        return .run
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
}
