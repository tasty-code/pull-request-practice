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
    case pleaseInputStudentNameToDelete = "삭제할 학생의 이름을 입력해주세요"
    case deletedStudent = "학생을 삭제하였습니다."
    case cannotFindStudent = "학생을 찾지 못했습니다."
    case pleaseInputNameAndGradeToUpdate = """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """
    case pleaseInputStudentNameWantToShowGPA = "평점을 알고싶은 학생의 이름을 입력해주세요"
    case notExistGrade = "성적이 존재하지 않습니다"
    case pleaseInputNameAndSubjectToDelete = """
        성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift
        """
    case deletedGrade = "과목의 성적이 삭제되었습니다."
}

// enum에 명시한 타입에 해당하는 메시지만 출력
func printMessage(messageType: Message) {
    print(messageType.rawValue)
}
