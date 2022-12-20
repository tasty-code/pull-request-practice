//
//  main.swift
//  MyCreditManager_dosh.kor
//
//  Created by 신동오 on 2022/12/06.
//

import Foundation
import CoreData

let dataManager = CoreDataManager()

while true {
    
    var finishFlag = 0
    
    print("원하는 기능을 입력해주세요 \n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    let menuInput = readLine()
    
    if menuInput == "X" {
        print("프로그램을 종료합니다...")
        break
    }
    
    switch menuInput {
    case "1":
        print("추가할 학생의 이름을 입력해주세요")
        
        let userInput = readLine()
        
        // ==================== input check(S) ====================
        // 곧바로 엔터친 경우
        if userInput == "" {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        
        // 스페이스가 포함된 경우
        if let userInput = userInput {
            if userInput.contains(" ") {
                print("입력이 잘못되었습니다. 다시 확인해 주세요")
                break
            }
        }
        
        // 알파벳, 숫자, + 기호 이외 문자를 입력한 경우
        for i in userInput! {
            if permittedString.contains(String(i)) == false {
                print("알파벳 대문자, 소문자, 숫자, + 기호만 입력이 가능합니다.")
                finishFlag = 1
                break
            }
        }
        
        if finishFlag == 1 { break }
        // ==================== input check(E) ====================
        // 이미 등록된 이름인지 확인
        let gradeCardArray: [GradeCard] = dataManager.readGradeCards()
        for gradeCard in gradeCardArray {
            if let name = gradeCard.name {
                if name == userInput! {
                    print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                    finishFlag = 1
                    break
                }
            }
        }
        
        if finishFlag == 1 { break }
        
        // 입력받은 이름을 저장한다.
        dataManager.createGradeCard(name: userInput!, subject: nil, grade: nil)
        print("\(userInput!) 학생을 추가했습니다.")
        
    case "2":
        print("삭제할 학생의 이름을 입력해주세요")
        
        let userInput = readLine()
        
        // ==================== input check(S) ====================
        // 곧바로 엔터친 경우
        if userInput == "" {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        
        // 스페이스가 포함된 경우
        if let userInput = userInput {
            if userInput.contains(" ") {
                print("입력이 잘못되었습니다. 다시 확인해 주세요")
                break
            }
        }
        // 알파벳, 숫자, + 기호 이외 문자를 입력한 경우
        for i in userInput! {
            if permittedString.contains(String(i)) == false {
                print("알파벳 대문자, 소문자, 숫자, + 기호만 입력이 가능합니다.")
                finishFlag = 1
                break
            }
        }
        
        if finishFlag == 1 { break }
        // ==================== input check(E) ====================
        
        // context 에서 데이터 가져오기
        let fetchedGradeCards: [GradeCard] = dataManager.readGradeCards()
        var willBeDeletedGradeCards: [GradeCard] = []
        
        for fetchedGradeCard in fetchedGradeCards {
            if fetchedGradeCard.name == userInput {
                willBeDeletedGradeCards.append(fetchedGradeCard)
            }
        }
        
        // 입력 받은 이름이 context 에 있는/없는 경우
        if willBeDeletedGradeCards.isEmpty {
            print("\(userInput!) 학생을 찾지 못했습니다.")
            break
        } else {
            for willDeleteGradeCard in willBeDeletedGradeCards {
                dataManager.deleteGradeCard(data: willDeleteGradeCard)
            }
            print("\(userInput!) 학생을 삭제하였습니다.")
        }
        
    case "3":
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해 주세요.\n 입력예) Mickey Swift A+ \n 만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        
        let userInput = readLine()
        
        // ==================== input check(S) ====================
        // 곧바로 엔터친 경우
        if userInput == "" {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        
        // 알파벳, 숫자, + 기호, " " 이외 문자를 입력한 경우
        for i in userInput! {
            if permittedString.contains(String(i)) == false {
                print("알파벳 대문자, 소문자, 숫자, + 기호만 입력이 가능합니다.")
                finishFlag = 1
                break
            }
        }
        
        if finishFlag == 1 { break }
        
        // 스페이스를 두 번 입력하였는가?(3개의 단어로 쪼개지는지)
        if userInput!.filter({ $0 == " "}).count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        // 스페이스 두 번이 연속으로 친건 아닌가?
        let changeSpaceString = userInput!.replacingOccurrences(of: " ", with: "*")
        if changeSpaceString.contains("**") {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        // ==================== input check(E) ====================
        
        // 입력을 name, subject, grade 로 분리하기
        let firstSpaceIndex = userInput!.firstIndex(of: " ")!
        let lastSpaceIndex = userInput!.lastIndex(of: " ")!

        let behindOfFirstSpaceIndex = userInput!.index(firstSpaceIndex, offsetBy: 1)
        let behindOfSecondSpaceIndex = userInput!.index(lastSpaceIndex, offsetBy: 1)

        let name = String(userInput![..<firstSpaceIndex])
        let subject = String(userInput![behindOfFirstSpaceIndex..<lastSpaceIndex])
        let grade = String(userInput![behindOfSecondSpaceIndex...])
        
        // context 에서 데이터 가져오기
        let fetchedGradeCards: [GradeCard] = dataManager.readGradeCards()
        var GradeCards: [GradeCard] = []
        
        for fetchedGradeCard in fetchedGradeCards {
            if fetchedGradeCard.name == name {
                GradeCards.append(fetchedGradeCard)
            }
        }
        
        // userInput 으로 받은 name이 context 에 있는/없는 경우
        if GradeCards.isEmpty {
            print("\(name) 학생을 찾지 못했습니다.")
            break
        } else {
            // 과목명이 있으면 update
            for GradeCard in GradeCards {
                if GradeCard.subject == subject {
                    GradeCard.grade = grade
                    dataManager.saveToContext()
                    finishFlag = 1
                    print("\(name) 학생의 \(subject) 과목이 \(grade)로 변경되었습니다.")
                    break
                }
            }
            if finishFlag == 1 { break }
        }
        
        // 과목명이 없다면 create()
        dataManager.createGradeCard(name: name, subject: subject, grade: grade)
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가되었습니다.")
        
        
    case "4":
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해 주세요.\n 입력예) Mickey Swift")
        
        let userInput = readLine()
        
        // ==================== input check(S) ====================
        // 곧바로 엔터친 경우
        if userInput == "" {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        // 알파벳, 숫자, + 기호, " " 외 문자를 입력한 경우
        for i in userInput! {
            if permittedString.contains(String(i)) == false {
                print("알파벳 대문자, 소문자, 숫자, + 기호만 입력이 가능합니다.")
                finishFlag = 1
                break
            }
        }
        
        if finishFlag == 1 { break }
        
        // userInput에 스페이스 한 번이 있는가?
        if userInput!.filter({ $0 == " "}).count != 1 {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        // ==================== input check(E) ====================
        
        // 2 개로 분리하기
        let firstSpaceIndex = userInput!.firstIndex(of: " ")!
        let behindOfFirstSpaceIndex = userInput!.index(firstSpaceIndex, offsetBy: 1)

        let name = String(userInput![..<firstSpaceIndex])
        let subject = String(userInput![behindOfFirstSpaceIndex...])
        
        // context 에서 데이터 가져오기
        let fetchedGradeCards: [GradeCard] = dataManager.readGradeCards()
        var GradeCards: [GradeCard] = []
        
        for fetchedGradeCard in fetchedGradeCards {
            if fetchedGradeCard.name == name {
                GradeCards.append(fetchedGradeCard)
            }
        }
        
        // userInput 으로 받은 학생이 context 에 있는/없는 경우
        if GradeCards.isEmpty {
            print("\(name) 학생을 찾지 못했습니다.")
            break
        } else {

        }
        
        for GradeCard in GradeCards {
            if GradeCard.subject == subject {
                dataManager.deleteGradeCard(data: GradeCard)
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                finishFlag = 1
                break
            }
        }
        
        // 지우려는 과목이 없다
        if finishFlag != 1 {
            print("\(name) 학생의 \(subject) 과목의 성적이 없습니다.")
        }
        
    case "5":
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        let userInput = readLine()
        
        // ==================== input check(S) ====================
        // 곧바로 엔터친 경우
        if userInput == "" {
            print("입력이 잘못되었습니다. 다시 확인해 주세요")
            break
        }
        
        // 스페이스가 포함된 경우
        if let userInput = userInput {
            if userInput.contains(" ") {
                print("입력이 잘못되었습니다. 다시 확인해 주세요")
                break
            }
        }
        // 알파벳, 숫자, + 기호 외 문자를 입력한 경우
        for i in userInput! {
            if permittedString.contains(String(i)) == false {
                print("알파벳 대문자, 소문자, 숫자, + 기호만 입력이 가능합니다.")
                finishFlag = 1
                break
            }
        }
        
        if finishFlag == 1 { break }
        // ==================== input check(E) ====================
        
        
        // context 에서 데이터 가져오기
        let fetchedGradeCards: [GradeCard] = dataManager.readGradeCards()
        var studentGradeCards: [GradeCard] = []
        
        for fetchedGradeCard in fetchedGradeCards {
            if fetchedGradeCard.name == userInput {
                studentGradeCards.append(fetchedGradeCard)
            }
        }
        
        // userInput 으로 받은 학생이 context 에 있는/없는 경우
        if studentGradeCards.isEmpty {
            print("\(userInput!) 학생을 찾지 못했습니다.")
            break
        } else {
            var gradeSum = 0.0
            var subjectCount = 0.0
            var gpa = 0.0
            
            for studentGradeCard in studentGradeCards {
                switch studentGradeCard.grade! {
                case "A+":
                    gradeSum += 4.5
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "A0":
                    gradeSum += 4.0
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "B+":
                    gradeSum += 3.5
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "B0":
                    gradeSum += 3.0
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "C+":
                    gradeSum += 2.5
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "C0":
                    gradeSum += 2.0
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "D+":
                    gradeSum += 1.5
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "D0":
                    gradeSum += 1.0
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                case "F":
                    gradeSum += 0.0
                    subjectCount += 1
                    print("\(studentGradeCard.subject!): \(studentGradeCard.grade!)")
                default:
                    break
                }
            }
            gpa = gradeSum / subjectCount
            
            if subjectCount == 0 {
                print("평점: 0.0")
            } else {
                print("평점: \(String(format: "%.2f", gpa))")
            }
        }
        
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해 주세요")
        break
    }
}
