//
//  main.swift
//  MyCreditManager_kimye9808
//
//  Created by 김용재 on 2022/12/06.
//

import Foundation

// 이름, subject, 성적을 튜플을 넣어주는 리스트
var temp : [(String,String,String)] = [("","","")]

// 이름 추가 삭제용 리스트
var name: [String] = []

// 이름이 존재하는 지 확인해보는 함수
func checkName(temp: [(String,String,String)], findingA: String, findingB: String) -> Bool {
    let count = temp.count
    var find = false
    for i in 0...(count-1){
        if temp[i].0 == findingA && temp[i].1 == findingB{
            find = true
        } else {
            continue
        }
    }
    return find
}

// 이름이 존재한다면, 리스트 중에서 몇번째 인지 index를 알려주는 함수
func checkIndex(temp: [(String,String,String)], findingA: String, findingB: String) -> Int{
    let count = temp.count
    var index = 0
    for i in 0...(count-1){
        if temp[i].0 == findingA && temp[i].1 == findingB {
            break
        } else {
            index += 1
        }
    }
    return index
}

// score과 subject를 던지는 함수
func calculateScore(temp: [(String,String,String)], who: String) -> ([String],[String]) {
    let count = temp.count
    var subject: [String] = []
    var score: [String] = []
    for i in 0...(count-1){
        if temp[i].0 == who{
            subject.append(temp[i].1)
            score.append(temp[i].2)
        } else {
            continue
        }
    }
    return (subject, score)
}

// 성적의 총합을 계산해주는 함수
func sumScore(scores:[String]) -> Double{
    var sum: Double = 0
    for i in 0...(scores.count-1){
        if scores[i] == "A+"{
            sum += 4.5
        } else if scores[i] == "A0"{
            sum += 4
        } else if scores[i] == "B+"{
            sum += 3.5
        } else if scores[i] == "B0"{
            sum += 3
        } else if scores[i] == "C+"{
            sum += 2.5
        } else if scores[i] == "C0"{
            sum += 2
        } else if scores[i] == "D+"{
            sum += 1.5
        } else if scores[i] == "D0"{
            sum += 1
        } else {
            sum += 0
        }
    }
    return sum
}

// 같은 말하는 함수 따로 빼주기
func macro(){
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}

print("----------------------")
macro()
print("----------------------")

var input = readLine()!

while input != "X" {
    
    if input == "1" {
        print("추가할 학생의 이름을 입력해주세요!")
        input = readLine()!
        if name.contains(input){
            print("\(input)는 이미 존재하는 이름입니다. 추가하지 않습니다.")
        } else {
            name.append(input)
            print("추가합니다!")
        }
        print("----------------------")
        macro()
        print("----------------------")

        
    } else if input == "2"{
        print("삭제할 학생의 이름을 입력해주세요!")
        input = readLine()!
        if name.contains(input){
            if let firstIndex = name.firstIndex(of: input) {
                name.remove(at: firstIndex)
            }
            print("\(input)를 삭제합니다!")
        } else {
            print("\(input) 학생을 찾지못했습니다!")
        }
        print("----------------------")
        macro()
        print("----------------------")
        
    } else if input == "3"{
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let add = readLine()!.components(separatedBy:" ")
        
        // 이름이 존재하는 지 확인하고, 입력 예처럼 작성했는 지 확인, 그리고 추가하는건지 변경하는것인지 확인하기 (추가할 경우)
        if add.count == 3 && name.contains(add[0]) && !checkIsIn(temp: temp, findingA: add[0], findingB: add[1]){
            print("\(add[0])학생의 \(add[1]) 과목이 \(add[2])로 추가되었습니다.")
            temp.append((add[0],add[1],add[2]))
        
            // 입력 예처럼 작성했는 지 확인하고, 추가하는것인지 변경하는 것인지 확인하기 (변경할 경우)
        } else if add.count == 3 && checkName(temp: temp, findingA: add[0], findingB: add[1]){
            temp.remove(at: checkIndex(temp: temp, findingA: add[0], findingB: add[1]))
            temp.append((add[0],add[1],add[2]))
            print("\(add[0])학생의 \(add[1]) 과목이 \(add[2])로 변경되었습니다.")
        }
        // 변경도 아니고 추가도 아닌 잘못된 입력이 들어왔을 경우
        else {
            print("입력이 잘못되었습니다. 다시 확인해주십시요")
            print("추가가 안된 학생일 수 있습니다!")
        }
        print("----------------------")
        macro()
        print("----------------------")

        
    } else if input == "4"{
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        let add = readLine()!.components(separatedBy:" ")
        
        // 입력예처럼 작성했는지 확인하고, 해당 학생이 과목을 수강했는지 확인하기(수강했을 경우) -> 삭제 가능
        if add.count == 2 && checkName(temp: temp, findingA: add[0], findingB: add[1]){
            print("\(add[0])학생의 \(add[1])과목이 삭제되었습니다.")
            temp.remove(at: checkIndex(temp: temp, findingA: add[0], findingB: add[1]))
            
            // 입력예처럼 작성했는 지 확인하고, 해당 과목을 수강했는지 확인하기(수강안했을 경우) -> 삭제 불가능
        } else if add.count == 2 && !checkName(temp: temp, findingA: add[0], findingB: add[1]){
            print("\(add[0])학생은 \(add[1])과목을 수강하지 않습니다!")
            
            // 입력예처럼 작성했는 지 확인하고, 이름 리스트에 있는 지 확인하기
        } else if add.count == 2 && !name.contains(add[0]){
            print("\(add[0])이라는 학생은 존재하지 않습니다.")
        } else {
            print("입력이 잘못되었습니다! 다시 확인부탁드리겠습니다.")
        }
        print("----------------------")
        macro()
        print("----------------------")

        
    } else if input == "5"{
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        input = readLine()!
        // 이름 리스트에 있을 경우만 평점을 계산할 수 있다.
        if name.contains(input){
            var subjects : [String] = []
            var scores : [String] = []
            var sum : Double = 0
            var mid : Double = 0
            (subjects, scores) = calculateScore(temp: temp, who: input)
            sum = sumScore(scores: scores)
            mid = sum/Double(subjects.count)
            print("----------------------")
            print("!!\(input)!!")
            for i in 0...(subjects.count-1){
                print("\(subjects[i]) : \(scores[i])")
            }
            print("평점 :\(String(format: "%.2f",mid))")
            
        } else if !name.contains(input) {
            print("\(input)학생은 존재하지 않습니다.")
        } else {
            print("입력이 잘못되었습니다! 다시 확인부탁드리겠습니다.")
        }
        print("----------------------")
        macro()
        print("----------------------")
    } else {
        print("----------------------")
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요!")
        macro()
        print("----------------------")

    }
    input = readLine()!
}
print("프로그램을 종료합니다....")
