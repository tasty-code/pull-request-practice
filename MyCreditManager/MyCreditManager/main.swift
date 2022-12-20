//
//  main.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

// 설명문구 출력 후 readLine() 리턴
func getInput() -> String? {
    printMessage(messageType: .input)
    return readLine()
}

func runProgram() {
    var isQuitProgram = false

    // EOF(Ctrl + D)는 종료로 처리
    while !isQuitProgram, let input = getInput() {
        // enum에 명시하지 않은 명령어는 에러로 처리
        guard let command = Command(rawValue: input) else {
            printMessage(messageType: .error)
            continue
        }
        isQuitProgram = executeCommand(command)
    }
    printMessage(messageType: .quit)
}

runProgram()
