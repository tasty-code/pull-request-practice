//
//  StringLiterals.swift
//  PR-Practice-MyCreditManager
//
//  Created by devxsby on 2022/12/20.
//

import Foundation

struct StringLiterals {
    
    public struct Menu {
        
        /// 프로그램 시작
        static let startProgram =  """
                                   원하는 기능을 입력해주세요
                                   1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
                                   """
        /// 메뉴 입력 에러
        static let wrongMenu = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        
        /// 나머지 입력 에러
        static let wrongInput = "입력이 잘못되었습니다. 다시 확인해주세요"
        
        /// 프로그램 종료
        static let exitProgram = "프로그램을 종료합니다..."
    }
    
    struct Student {
        
        /// 학생추가
        static let addStudentMessage = "추가할 학생의 이름을 입력해주세요."
        static let addStudentSuccess = "학생을 추가했습니다."
        
        /// 학생 삭제
        static let deleteStudentMessage = "삭제할 학생의 이름을 입력해주세요."
        static let deleteStudentSuccess = "학생을 삭제하였습니다."
        
        /// 에러 메시지
        static let wrongStudentInputError = "입력이 잘못되었습니다. 다시 확인해주세요."
        static let alredyExistError = "은 이미 존재하는 학생입니다. 추가하지 않습니다."
        static let nonExistError = "학생을 찾지 못했습니다."
    }
    
    public struct Grades {
        
        /// 성적 추가(변경)
        static let addOrChangeGradesMessage = """
                                              성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                                              입력예) Mickey Swift A+
                                              만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                                              """
        
        static let studentSuccess = "학생의"
        static let subjectSuccess = "과목이"
        static let scoreSuccess = "로 추가(변경)되었습니다."
        static let deleteSuccess = "과목의 성적이 삭제되었습니다."
        
        /// 성적 삭제
        static let deleteGradesMessage = """
                                  성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                                  입력예) Mickey Swift
                                  """
        
        /// 평점 보기
        static let showGradesMessage = "평점을 알고싶은 학생의 이름을 입력해주세요."
    }
}
