//
//  PrintMessage.swift
//  MyCreditManager_jasonLee0223
//
//  Created by Jason on 2022/12/06.
//

import Foundation

struct PrintMessage {
    func initial() {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }
    
    func defaultError() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    //MARK: - 학생 추가
    func enterStudentName() {
        print("추가할 학생의 이름을 입력해주세요")
    }
    
    func invalidInputNotice() {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    
    func addStudent(_ name: String) {
        print("\(name) 학생을 추가했습니다.")
    }
    
    func sameStudent(_ name: String) {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    }
    
    //MARK: - 학생 삭제
    func wishToDeleteStudentName() {
         print("삭제할 학생의 이름을 입력해주세요.")
    }
    
    func deleteStudent(_ name: String) {
        print("\(name) 학생을 삭제하였습니다.")
    }
    
    func notCollectDeleteStudent(_ name: String) {
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    //MARK: - 성적 추가
    func enterTheGradeAndSubject() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    }
    
    func collectThreeInputValue(_ name: String, _ subject: String, _ grade: String) {
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    }
    
    //MARK: - 성적 삭제
    func wishToDeleteGrade() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
    }
    
    func canNotFoundStudent(_ name: String) {
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    func deleteGrade(_ name: String, _ subject: String) {
        print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
    }
    
    //MARK: - 평점보기
    func wishToKnowAverage() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    }
    
    //MARK: - 종료
    func endProcess() {
        print("프로그램을 종료합니다...")
    }
}
