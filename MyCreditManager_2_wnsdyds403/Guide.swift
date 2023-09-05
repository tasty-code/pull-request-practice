//
//  Guidance.swift
//  MyCreditManager_2_wnsdyds403
//
//  Created by 지준용 on 2023/08/14.
//

import Foundation

enum Guide {
    
    // MARK: - Common
    
    static let studentName = "학생의 이름을 입력해주세요"
    static let checkInput = "입력이 잘못되었습니다. 다시 확인해주세요."
    static let notFoundStudent = "학생을 찾지 못했습니다."
    static let notFoundGrade = "성적을 찾지 못했습니다."
    
    // MARK: - ShowMenu
    
    static let menus =  """
                        원하는 기능을 입력해주세요.
                        1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
                        """
    static let exit = "프로그램을 종료합니다..."
    static let reselectMenu = "입력이 잘못되었습니다. 1~5사이의 숫자 혹은 X를 입력해주세요."
    
    // MARK: - AddStudent
    
    static let alreadyExistence =  "이미 존재하는 학생입니다. 추가하지 않습니다."
    static let addedStudent = "학생을 추가했습니다."
    
    // MARK: - DeleteStudent
    
    static let deletedStudent = "학생을 삭제하였습니다."
    
    // MARK: - AddAndUpdateGrade
    
    static let inputGrade = """
                            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                            입력예) Mickey Swift A+
                            만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
                            """
    
    // MARK: - DeleteGrade
    
    static let inputStudentNameAndSubject = """
                                     성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                                     입력예) Mickey Swift
                                     """
    static let deletedGrade = "성적이 삭제되었습니다."
}
