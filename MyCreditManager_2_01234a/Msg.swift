//
//  msg.swift
//  MyCreditManager_2_01234a
//
//  Created by Wonji Ha on 2023/08/15.
//

import Foundation

/// 모든 입/출력 관련 메시지 구조체입니다.

struct Msg {
    struct Input {
        static let menuMsg: String = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
        static let menuError: String = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        static let inputError: String = "입력이 잘못되었습니다. 다시 확인해주세요."
    }
    
    struct CreateStudent {
        static let addMsg = "추가할 학생의 이름을 입력해주세요"
        static let addSuccess = "학생을 추가했습니다."
        static let errorMsg = "은 이미 존재하는 학생입니다. 추가하지 않습니다."
    }
    
    struct DeleteStudent {
        static let delMsg = "삭제할 학생의 이름을 입력해주세요"
        static let delSuccess = "학생을 삭제하였습니다."
    }
    
    struct UpdateGrade {
        static let addMsg = """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """
        static let errorMsg = "존재하지 않는 성적입니다. A+, A0 의 형태로 입력해주세요."
    }
    
    struct DeleteGrade {
        static let delMsg = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift"
        static let errorMsg = "과목을 찾지 못했습니다."
    }
    
    struct ReadGrade {
        static let msg = "평점을 알고싶은 학생의 이름을 입력해주세요"
        static let errorMsg = "성적을 찾지 못했습니다."
    }
    
    struct ErrorMsg {
        static let noStudent = "학생을 찾지 못했습니다."
    }
    
    struct Exit {
        static let msg = "프로그램을 종료합니다..."
    }

}
