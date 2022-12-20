//
//  Message.swift
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

// enum에 명시한 타입에 해당하는 메시지만 출력
func printMessage(messageType: Message) {
    print(messageType.rawValue)
}
