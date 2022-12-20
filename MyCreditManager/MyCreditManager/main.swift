//
//  main.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

enum Message: String {
    case input = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
    case error = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
    case quit = "프로그램을 종료합니다..."
}

enum Command: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case updateGrade = "3"
    case deleteGrade = "4"
    case showGPA = "5"
    case quitProgram = "X"
}

// enum에 명시한 타입에 해당하는 메시지만 출력
func printMessage(messageType: Message) {
    print(messageType.rawValue)
}

// 설명문구 출력 후 readLine() 리턴
func getInput() -> String? {
    printMessage(messageType: .input)
    return readLine()
}

func executeCommand(_ command: Command) -> Bool {
    switch command {
    case .addStudent: print("1: 학생추가")
    case .deleteStudent: print("2: 학생삭제")
    case .updateGrade: print("3: 성적추가(변경)")
    case .deleteGrade: print("4: 성적삭제")
    case .showGPA: print("5: 평점보기")
    case .quitProgram: return true
    }
    return false
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
