//
//  Modules.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

typealias Student = String

class Management {
    var students: [Student: [ReportCard]] = [:]
}

struct ReportCard {
    var subject: String
    var grade: String
}

enum Pattern: String {
    case input = "^[0-9a-zA-Z+]*$"
}

enum Score: Double {
    case APlus = 4.5
    case AZero = 4.0
    case BPlus = 3.5
    case BZero = 3.0
    case CPlus = 2.5
    case CZero = 2.0
    case DPlus = 1.5
    case DZero = 1.0
    case F = 0.0
}

enum Grade: String {
    case APlus = "A+"
    case AZero = "A0"
    case BPlus = "B+"
    case BZero = "B0"
    case CPlus = "C+"
    case CZero = "C0"
    case DPlus = "D+"
    case DZero = "D0"
    case F = "F"
}

enum Commands: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case updateGrade = "3"
    case removeGrade = "4"
    case reportCard = "5"
    case exit = "X"
}

enum Errors: String {
    case main = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
    case input = "입력이 잘못되었습니다. 다시 확인해주세요."
    case containStudent = "은 이미 존재하는 학생입니다. 추가하지 않습니다."
    case searchStudent = " 학생을 찾지 못했습니다."
    case searchSubject = " 과목을 찾지 못했습니다."
}

extension Errors {
    func printSelf() {
        print(self.rawValue)
    }
}
enum Questions: String {
    case main = "원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료"
    case addStudent = "추가할 학생의 이름을 입력해주세요."
    case deleteStudent = "삭제할 학생의 이름을 입력해주세요"
    case updateGrade = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요."
    case removeGrade = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요."
    case reportCard = "평점을 알고 싶은 학생의 이름을 입력해주세요"
}

class Operations {
    func addStudent(_ student: Student) {
        print("\(student) 학생을 추가했습니다.")
    }
    func deleteStudent(_ student: Student) {
        print("\(student) 학생을 삭제하였습니다.")
    }
    func updateGrade(_ reportCard: ReportCard, of student: Student) {
        print("\(student) 학생의 \(reportCard.subject) 과목이 \(reportCard.grade)로 추가(변경)되었습니다.")
    }
    func removeGrade(_ subject: String, of student: Student) {
        print("\(student) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
    }
    var exit: String {
        return "프로그램을 종료합니다..."
    }
}


