//
//  Message.swift
//  MyCreditManager
//
//  Created by jun on 2022/12/20.
//

import Foundation

enum Message: String {
    case menu = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
    case menuError = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
    case quit = "프로그램을 종료합니다..."
    case pleaseInputStudentNameToAdd = "추가할 학생의 이름을 입력해주세요"
    case inputError = "입력이 잘못되었습니다. 다시 확인해주세요."
    case cannotAddStudentAlreadyExistName = "은 이미 존재하는 학생입니다. 추가하지 않습니다."
    case addedStudent = "학생을 추가했습니다."
}

// enum에 명시한 타입에 해당하는 메시지만 출력
func printMessage(messageType: Message) {
    print(messageType.rawValue)
}
