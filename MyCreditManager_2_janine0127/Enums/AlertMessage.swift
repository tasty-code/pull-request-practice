//
//  AlertMessage.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/21.
//

import Foundation

enum Alert: Int, Codable {
    case initial = 0
    case failed = 1
    case wrong = 2
    case end = 3
    
    var message: String {
        switch self {
        case .initial:
            return """
            원하는 기능을 입력해주세요
            1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
            """
        case .failed:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        case .wrong:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .end:
            return "프로그램을 종료합니다..."
        }
    }
}
