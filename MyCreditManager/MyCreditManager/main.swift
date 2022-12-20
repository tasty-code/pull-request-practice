//
//  main.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

enum State {
    case quit
    case run
}

// 설명문구 출력 후 readLine() 리턴
func getLine(messageType: Message) -> String? {
    printMessage(messageType: messageType)
    return readLine()
}

// 학생 정보 저장할 클래스의 인스턴스
let student = Student()

func runProgram() {
    var state: State = .run

    // EOF(Ctrl + D)는 종료로 처리
    while state != .quit, let input = getLine(messageType: .menu) {
        // enum에 명시하지 않은 명령어는 에러로 처리
        guard let command = Command(rawValue: input) else {
            printMessage(messageType: .menuError)
            continue
        }
        state = executeCommand(command)
    }
    printMessage(messageType: .quit)
}

runProgram()
