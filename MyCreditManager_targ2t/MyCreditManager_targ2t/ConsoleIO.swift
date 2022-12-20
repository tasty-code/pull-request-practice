//
//  ConsoleIO.swift
//  MyCreditManager_targ2t
//
//  Created by 김보미 on 2022/12/06.
//

import Foundation


/// 콘솔의 모든 입력 및 출력 요소를 관리하는 클래스이다.
class ConsoleIO {

    // MARK: - 메뉴 관련 메세지 출력 함수 목록
    /// 기능을 입력받기 위한 메뉴 안내를 콘솔에 출력하기 위한 함수이다.
    func printAllMenu() {
        print("원하는 기능을 입력해 주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }
    
    /// 메뉴 선택 시 잘못된 입력을 하는 경우 에러 문구를 출력하는 함수이다.
    func printMenuInputError() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    // MARK: - 기능 내부에서 반복적으로 사용되는 에러 메세지 출력 함수 목록
    /// 기능 내부에서 잘못된 입력을 하는 경우 동일 내용의 메세지 출력이 중복되므로 함수로 별도 구현하여 사용한다.
    func printFuncInputError() {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    
    /// 없는 학생에 대한 에러 문구를 출력하는 함수이다.
    func printStudentMissingError(name: String) {
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    // MARK: - 학생 추가 메뉴 관련 메세지 출력 함수 목록
    /// 학생 추가 메뉴 안내 문구를 출력하는 함수이다.
    func printAddStudentGuid() {
        print("추가할 학생의 이름을 입력해주세요")
    }
    
    /// 학생 추가 메뉴 중 중복 에러 문구를 출력하는 함수이다.
    func printAddStudentDuplicateError(name: String) {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    }
    
    /// 학생 추가가 정상적으로 실행된 후 안내 문구를 출력하는 함수이다.
    func printAddStudentSuccess(name: String) {
        print("\(name) 학생을 추가했습니다")
    }
    
    // MARK: - 학생 삭제 메뉴 관련 메세지 출력 함수 목록
    /// 학생 삭제 메뉴 안내 문구를 출력하는 함수이다.
    func printDeleteStudentGuid() {
        print("삭제할 학생의 이름을 입력해주세요")
    }
    
    /// 학생 삭제 메뉴에서 정상적으로 학생을 삭제한 후 안내 문구를 출력하는 함수이다.
    func printDeleteStudentSuccess(name: String) {
        print("\(name) 학생을 삭제하였습니다.")
    }
    
    // MARK: - 성적 추가 메뉴 관련 메세지 출력 함수 목록
    /// 성적 추가 메뉴 안내 문구를 출력하는 함수이다.
    func printAddGradeGuid() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해 주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재한다면 기존 점수가 갱신됩니다.")
    }
    
    /// 성적 추가 메뉴에서 정상적으로 성적을 추가(변경)한 후 안내 문구를 출력하는 함수
    func printAddGradeSuccess(name: String, subject: String, grade: String) {
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    }
    
    // MARK: - 성적 삭제 메뉴 관련 메세지 출력 함수 목록
    /// 성적 삭제 메뉴 안내 문구를 출력하는 함수이다.
    func printDeleteGradeGuid() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해 주세요.")
        print("입력예) Mickey Swift")
    }
    
    /// 성적 삭제 메뉴에서 정상적으로 성적을 추가(변경)한 후 안내 문구를 출력하는 함수이다.
    func printDeleteGradeSuccess(name: String, subject: String) {
        print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
    }
    
    // MARK: - 평점 메뉴 관련 메세지 출력 함수 목록
    /// 평점 메뉴 안내 문구를 출력하는 함수이다.
    func printAverageGuid() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
    }
    
    /// 평점 메뉴에서 과목들을 출력하는 함수이다.
    func printAverageSubjectsSuccess(subject: String, grade: String) {
        print("\(subject): \(grade)")
    }
    
    /// 평점 메뉴에서 평점을 출력하는 함수이다.
    func printAverageSuccess(average: Double) {
        /// 소수점을 2자리까지만 보여주게 하는 String format을 사용한다.
        print("평점: \(String(format: "%.2f", average))")
    }
    
    // MARK: - 프로그램 종료 메세지 출력 함수
    /// 프로그램 종료 문구를 출력하는 함수이다.
    func printQuitGuide() {
        print("프로그램을 종료합니다...")
    }
    
    // MARK: - 데이터 입력 관련 함수
    /// 사용자에게 데이터를 입력받는 함수이다.
    func getInput() -> String {
        /// FileHandle은 파일 디스크립터를 객체 지향 API로 감싼 얇은 래퍼로, 기본입력을 keyboard 변수에 할당한다.
        /// availableData는 입력받은 데이터를 읽어오는 역할을 수행한다.
        let inputData = FileHandle.standardInput.availableData
        /// inputData의 데이터를 utf8형식의 String으로 Encoding하는 과정이다.
        /// 데이터가 없을 수도 있으므로 없는 경우 공백을 반환하도록 언래핑한다.
        let strData = String(data: inputData, encoding: String.Encoding.utf8) ?? ""
        /// newline(엔터를 누르면 입력되는 새 줄)을 제거하고 남은 문자열을 return한다.
        return strData.trimmingCharacters(in: CharacterSet.newlines)
    }
    
}
