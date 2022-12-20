//
//  main.swift
//  Git_ Exercise
//
//  Created by 잼킹 on 2022/12/18.
//

import Foundation
import RealmSwift

while true {
    
    print("원하는 기능을 입력해주세요 \n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    if let input = readLine() {
        if input == "1" {
            studentAdd()
        } else if input == "2" {
            studentDelete()
        } else if input == "3" {
            gradeAdd()
        } else if input == "4" {
            gradeDelete()
        } else if input == "5" {
            totalGrade()
        } else if input == "X" {
            print("프로그램을 종료합니다...")
            break
        } else {
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

func studentAdd() {
    print("추가할 학생의 이름을 입력해주세요")
    
    // 학생 이름은 오직 영어.
    guard let studentName = readLineForName() else { return }
    addStudent(name: studentName)
}

func studentDelete() {
    print("삭제할 학생의 이름을 입력해주세요")
    
    // 학생 이름은 오직 영어.
    guard let studentName = readLineForName() else { return }
    deleteStudent(name: studentName)
}

func gradeAdd() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요. \n입력예) Mickey Swift A+ \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    guard let inputGrade = readLineForGradeAdd() else { return }
    // ["학생이름", "과목", "점수"]
    
    addStudentGrade(name: inputGrade[0], subject: inputGrade[1], score: inputGrade[2])
}

func gradeDelete() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요. \n입력예) Mickey Swift")
    
    guard let inputGrade = readLineForGradeDelete() else { return }
    // ["학생이름", "과목"]
    
    deleteStudentGrade(name: inputGrade[0], subject: inputGrade[1])
}

func totalGrade() {
    print("평점을 알고 싶은 학생의 이름을 입력해주세요")
    
    // 학생 이름은 오직 영어.
    guard let studentName = readLineForName() else { return }
    
    calculateGrade(name: studentName)
}

