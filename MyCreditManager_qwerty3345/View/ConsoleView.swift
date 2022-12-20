//
//  ConsoleView.swift
//  MyCreditManager_qwerty3345
//
//  Created by Mason Kim on 2022/12/07.
//

import Foundation

struct ConsoleView {
    static func userInput() -> String {
        return readLine() ?? ""
    }

    // MARK: - User Input

    static func printUserSelectMenu() {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }

    static func printUserSelectMenuError() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }

    static func printInputError() {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }


    // MARK: - Add Student

    static func printAddStudentInform() {
        print("추가할 학생의 이름을 입력해주세요")
    }

    static func printStudentAlreadyExists(name: String) {
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    }

    static func printAddStudentComplete(name: String) {
        print("\(name) 학생을 추가했습니다.")
    }


    // MARK: - Remove Student

    static func printRemoveStudentInform() {
        print("삭제할 학생의 이름을 입력해주세요")
    }

    static func printRemoveStudentComplete(name: String) {
        print("\(name) 학생을 삭제 하였습니다.")
    }

    static func printStudentNotFound(name: String) {
        print("\(name) 학생을 찾지 못했습니다.")
    }


    // MARK: - Update Score

    static func printUpdateScoreInform() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례대로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    }

    static func printUpdateScoreComplete(studentName: String, subjectName: String, grade: String) {
        print("\(studentName) 학생의 \(subjectName) 과목이 \(grade)로 추가(변경) 되었습니다.")
    }


    // MARK: - Remove Score
    static func printRemoveScoreInform() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례대로 작성해주세요.")
        print("입력예) Mickey Swift")
    }

    static func printSubjectNotFound(subjectName: String) {
        print("\(subjectName) 과목이 존재하지 않습니다.")
    }

    static func printRemoveScoreComplete(studentName: String, subjectName: String) {
        print("\(studentName) 학생의 \(subjectName) 과목 성적이 삭제되었습니다.")
    }

    // MARK: - Show Score
    static func printShowScoreInform() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
    }

    // MARK: - Program
    static func printTerminateProgram() {
        print("프로그램을 종료합니다...")
    }

    static func printSaveDataInform() {
        print("데이터를 저장하였습니다.")
    }

    static func printLoadDataInform() {
        print("이전에 입력했던 데이터를 불러왔습니다.")
    }

}
