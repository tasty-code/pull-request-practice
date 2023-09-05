//
//  main.swift
//  MyCreditManager_2_howard89
//
//  Created by 전성수 on 2023/08/14.
//

import Foundation

//학생정보 저장 변수
var stInfo:[String:[String:Any]] = [:]

//프로그램 종료 여부체크
var closeCheck: String = "O"

//반복 메세지들
var selectMsg: String = "원하는 기능을 입력해주세요. \n 1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4:성적삭제, 5: 평점보기, X: 종료"
var selectMsgError: String = "뭔가 입력이 잘못되었습니다. 1~5사이의 숫자 혹은 X를 입력해주세요."
var globalErrorMsg: String = "입력이 잘못되었습니다. 다시 확인해주세요."

//기능별 함수
//학생 중복 체크
func searchName(name:String) -> Bool{
    var isHere: Bool = false
    
    for student in stInfo {
        if(student.key == name){
            isHere = true
        } else{
            isHere = false
        }
    }
    return isHere
}

//텍스트 유효성 검사
func validateStringsInArray(_ array: [String], against pattern: String) -> [Bool] {
    do {
        let regex = try NSRegularExpression(pattern: pattern)
        return array.map { string in
            let range = NSRange(string.startIndex..., in: string)
            return regex.firstMatch(in: string, range: range) != nil
        }
    } catch {
        return []
    }
}

//배열 전체 유효성 검사
func validCheck(arr:[String], pattern: String, count: Int) -> Bool{
    var check = false
    
    //유저 입력 항목 개수 체크
    if(arr.count < count){
        check = false
    } else {
        check = true
    }
    
    //텍스트 유효성 검사
    let pattern = pattern
    let validCheck = validateStringsInArray(arr, against: pattern)
    for (_, isValid) in validCheck.enumerated() {
        if (isValid && check) {
            check = true
        } else {
            check = false
            break
        }
    }
    
    return check
}

//등급 to 점수변환
func convertScore(scoreDict: [String : String]) -> Double{
    var convertedScore: Double = 0
    
    for (_ , score) in scoreDict{
        switch score {
            case "A+" :
                convertedScore += 4.5
            case "A0" :
                convertedScore += 4
            case "B+" :
                convertedScore += 3.5
            case "B0" :
                convertedScore += 3
            case "C+" :
                convertedScore += 2.5
            case "C0" :
                convertedScore += 2
            case "D+" :
                convertedScore += 1.5
            case "D0" :
                convertedScore += 1
            default :
            convertedScore += 0
        }
    }
    
    return convertedScore / Double(scoreDict.count)
}

//1. 학생 추가
func firstSelect(){
    print("추가할 학생의 이름을 입력해주세요.")
    let studentName = readLine()!
    let regExCheck = studentName.range(of:"^[0-9a-zA-Z]*$" , options: .regularExpression) != nil
    if(regExCheck){
        if(searchName(name: studentName)){
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            stInfo[studentName] = [:]
            print("\(studentName) 학생을 추가하였습니다.")
        }
            
    } else {
        print(globalErrorMsg)
    }
}

//2. 학생 삭제
func secondSelect(){
    print("삭제할 학생의 이름을 입력해주세요.")
    let studentName = readLine()!
    if(searchName(name: studentName)){
        stInfo[studentName] = nil
        print("\(studentName) 학생을 삭제하였습니다.")
    }else{
        print("\(studentName)학생을 찾지 못했습니다.")
    }
}

//3. 성적입력(변경)

func thirdSelect(){
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F등)을 띄어쓰기로 구분하여 차례로 작성해주세요. \n 입력예) Howard Swift A+ \n 만약에 학생의 성적 중 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    let gradeAdd = readLine()!.split(separator: " ")
    //String.SubSequence로 받은걸 String으로 전환
    let userInput: [String] = gradeAdd.map { String($0) }
    //전체 유효성 검사결과
    let wholeValidCheck = validCheck(arr: userInput, pattern: "^[0-9a-zA-Z+]*$", count: 3)
    
    
    //리스트에 학생이 존재하는지 확인
    if(stInfo.keys.contains(userInput[0]) && wholeValidCheck){
        //학생이 있으면, 입력한 과목이 있는지 확인 > 추가 or 변경 분기
        if ((stInfo[userInput[0]]?.keys.contains(userInput[1])) != nil){
            stInfo[userInput[0]]?[userInput[1]] = userInput[2]
            print("\(userInput[0])학생의 \(userInput[1])과목이 \(userInput[2])로 추가(변경) 되었습니다.")
        } else {
            stInfo[userInput[0]] = [userInput[1]:userInput[2]]
            print("\(userInput[0])학생의 \(userInput[1])과목이 \(userInput[2])로 추가(변경) 되었습니다.")
        }
    } else {
        print(globalErrorMsg)
    }
}

//4. 성적 삭제
func forthSelect(){
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요. \n 입력예) Howard Swift")
    let gradeRemove = readLine()!.split(separator: " ")
    let userInput: [String] = gradeRemove.map { String($0) }
    //전체 유효성 검사결과
    let wholeValidCheck = validCheck(arr: userInput, pattern: "^[a-zA-Z]*$", count: 2)
    
    if(stInfo.keys.contains(userInput[0])){
        if(wholeValidCheck && stInfo[userInput[0]]?.keys.contains(userInput[1]) != nil){
            stInfo[userInput[0]]?[userInput[1]] = nil
            print("\(userInput[0]) 학생의 \(userInput[1]) 성적이 삭제되었습니다.")
        } else {
            print(globalErrorMsg)
        }
    } else {
        print("\(userInput[0]) 학생을 찾지 못했습니다.")
    }
}

//5. 평점 조회

func fifthSelect(){
    print("평점을 알고싶은 학생의 이름을 입력해주세요.")
    let studentName = readLine()!
    var validCheck = false
    var scoreArr: Dictionary<String,String> = [:]
    var finalScore: Double = 0
    
    //성적이 입력되어있는지 체크해야됨. 학생만 추가되어있을 수 도 있음.
    if(stInfo.keys.contains(studentName) && !stInfo[studentName]!.isEmpty){
        validCheck = true
    } else {
        print("\(studentName) 학생이 없거나, 입력된 점수가 없습니다.")
    }
    
    if(validCheck){
        //평점 출력
        for (course, grade) in stInfo[studentName]!{
            scoreArr[course] = grade as? String
        }
        finalScore = convertScore(scoreDict: scoreArr)
        print(studentName)
        
        if (!scoreArr.isEmpty){
            for (courseName, grade2) in scoreArr {
                print("\(courseName): \(grade2)")
            }
            print("평점 : \(String(format: "%.2f", finalScore))")
        }
    }
}



//프로그램 실행부
while(closeCheck == "O"){
    print(selectMsg)
    let selectedNumber = readLine()!
    
    switch selectedNumber {
        case "1" :
            firstSelect()
        
        case "2" :
            secondSelect()
        
        case "3" :
            thirdSelect()
        
        case "4" :
            forthSelect()
        
        case "5" :
            fifthSelect()
        
        case "X" :
            closeCheck = "X"
            print("프로그램을 종료합니다...")
        
        default :
            print(selectMsgError)
    }
}
