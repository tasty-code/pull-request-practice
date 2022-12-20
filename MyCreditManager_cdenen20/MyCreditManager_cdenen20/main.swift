//
//  main.swift
//  MyCreditManager_cdenen20
//
//  Created by Junely on 2022/12/05.
//

import Foundation

//MARK: - 지난 실행기록 불러오기
readWholeData()

repeat {
    
    //MARK: - 원하는 기능 선택하기
    print("""
    원하는 기능을 입력해주세요
    1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
    """)
    inputMenu = readLine() ?? ""
    let _ = checkInput(chr: inputMenu)
    
    //MARK: - 선택한 기능 실행하기
    switch inputMenu {
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            inputData = readLine() ?? ""
            guard getInput(checkInput(str: inputData)) else { print(); continue }
            getInputs(inputData)
            let _ = Student(name: name)
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            inputData = readLine() ?? ""
            guard getInput(checkInput(str: inputData)) else { print(); continue }
            getInputs(inputData)
            print(Student.students.removeValue(forKey: name) == nil ? "\(name) 학생을 찾지 못했습니다." : "")
        case "3":
            print("""
            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
            입력예) Mickey Swift A+
            만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
            """)
            inputData = readLine() ?? ""
            guard getInput(checkInput(str: inputData)) else { print(); continue }
            getInputs(inputData)
            guard let student = Student.students[name] else { print("\(name) 학생을 찾지 못했습니다."); break }
            student.grades.updateValue(grade, forKey: subject)
            print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
        case "4":
            print("""
            성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
            입력예) Mickey Swift
            """)
            inputData = readLine() ?? ""
            guard getInput(checkInput(str: inputData)) else { print(); continue }
            getInputs(inputData)
            guard let student = Student.students[name] else { print("\(name) 학생을 찾지 못했습니다."); break }
            student.grades.removeValue(forKey: subject)
            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
        case "5":
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
            inputData = readLine() ?? ""
            guard getInput(checkInput(str: inputData)) else { print(); continue }
            getInputs(inputData)
            guard let student = Student.students[name] else { print("\(name) 학생을 찾지 못했습니다."); break }
            student.grades.sorted(by: { $0.key.count < $1.key.count }).forEach { print("\($0.key): \($0.value)") }
            print("평점 :", "\(student.overallScore)".replacingOccurrences(of: ".0", with: "").prefix(4))
        case "X":
            //MARK: - 지난 실행기록 저장하기
            saveWholeData()
            print("프로그램을 종료합니다...")
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    print()
    
} while inputMenu != "X"



