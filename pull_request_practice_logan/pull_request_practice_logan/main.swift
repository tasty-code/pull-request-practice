//
//  main.swift
//  pull_request_practice_logan
//
//  Created by DONGWOOK SEO on 2022/12/20.
//

import Foundation

let dataManager = DataManager()
dataManager.setStoredData()
runProgram()

func runProgram() {

    print("\n\n원하는 기능을 입력해주세요.\n| 1: 학생추가 | 2: 학생삭제 | 3: 성적추가(변경) | 4: 성적삭제 | 5: 평점보기 | X: 종료 |")
    
    let userInput: String? = readLine()?.lowercased()
    
    switch userInput {
    case "1":
        print("[ 학생추가 ]")
        dataManager.addStudent()
        runProgram()
        
    case "2":
        print("[ 학생삭제 ]")
        dataManager.deleteStudent()
        runProgram()
        
    case "3":
        print("[ 성적추가(변경) ]")
        dataManager.updateGrades()
        runProgram()
        
    case "4":
        print("[ 성적삭제 ]")
        dataManager.deleteGrade()
        runProgram()
        
    case "5":
        print("[ 평점보기 ]")
        dataManager.getCredit()
        runProgram()
        
    case "x":
        dataManager.saveData()
        print("🍕 프로그램을 종료합니다..")
   
    default:
        print("⚠️ 뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        runProgram()
    }
}
