//
//  main.swift
//  MyCreditManager_2_chsb1221
//
//  Created by 최승범 on 2023/08/14.
//

import Foundation

var studentNames: Set<String> = []
var studentScores: [String: String] = [:]
let gradeScore: [String: Double] = ["A+": 4.5, "A0": 4.0, "B+": 3.5, "B0": 3.0,"C+": 2.5, "C0": 2.0, "D+": 1.5, "D0": 1.0, "F": 0.0]
var programRun = true


func loadSavedData() -> (names: Set<String>, scores: [String: String])? {
    let defaults = UserDefaults.standard
    
    if let savedNames = defaults.array(forKey: "StudentNames") as? [String],
       let savedScores = defaults.dictionary(forKey: "StudentScores") as? [String: String] {
        return (Set(savedNames), savedScores)
    }
    
    return nil
}


func saveData(names: Set<String>, scores: [String: String]) {
    let defaults = UserDefaults.standard
    
    let savedNames = Array(names)
    defaults.set(savedNames, forKey: "StudentNames")
    defaults.set(scores, forKey: "StudentScores")
}

func appendName() {
    print("추가할 학생의 이름을 입력해주세요.")
    let input = readLine()!
    if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요\n")
    }
    else if studentNames.contains(input) == true {
        print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.\n")
    }
    else {
        studentNames.insert(input)
        print("\(input) 학생을 추가했습니다.")
    }
}

func deleteName() {
    print("삭제할 학생의 이름을 입력해주세요.")
    let input = readLine()!
    if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요\n")
    }
    else if studentNames.contains(input) == true {
        studentNames.remove(input)
        print("\(input) 학생을 삭제했습니다.\n")
    }
    else {
        print("\(input) 학생을 찾지못했습니다.")
    }
}

func appendScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적( A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력 예) Beom Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다. ")
    let input = readLine()!
    let components = input.components(separatedBy: " ")
    let score = components.contains("A+") || components.contains("A0") || components.contains("B+") || components.contains("B0") || components.contains("C+") || components.contains("C0") || components.contains("D+") || components.contains("D0") || components.contains("F")
    
    if studentNames.contains(components.first!) {
        
        if components.count >= 2 && score {
            let key = components.dropLast().joined(separator: " ")
            let value = components.last
            studentScores[key] = value
        }
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
    else {
        print("학생 명단에 없는 학생입니다.")
    }
    
}

func deleteScore() {
    print("성적을 삭제할 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력 예) Beom Swift")
    
    let input = readLine()!
    let components = input.components(separatedBy: " ")
    
    if studentScores.keys.contains(input) {
        studentScores.removeValue(forKey: input)
        print("\(components[0])의 \(components[1])과목의 성적이 삭제되었습니다.")
    }
    else if studentNames.contains(components.first!) == false {
        print("\(components.first!) 학생을 찾지 못했습니다.")
    }
    else  {
        print("\(components[1]) 과목을 찾지 못했습니다.")
    }
    
}

func averageScore() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    var sum = 0.0
    var count = 0.0
    var aver = 0.0
    let input = readLine()!
    if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요\n")
    }
    else if studentNames.contains(input) == false {
        print("\(input) 학생을 찾지 못했습니다.")
    }
    else {
        for (key,value) in studentScores {
            if key.contains(input) { 
                print("\(key.components(separatedBy: " ")[1]) : \(value)")
                count += 1.0
                sum += gradeScore[value] ?? 0.0
            }
            
        }
        aver = sum / count
        print("평점: \(aver)")
    }
    
}
if let savedData = loadSavedData() {
    studentNames = savedData.names
    studentScores = savedData.scores
    
    while programRun {
        
        print("원하는 기능을 입력해주세요\n")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4:성적삭제, 5: 평점보기, X: 종료\n")

        let input = readLine()
        switch input {
            case "1":
                appendName()
            case "2":
                deleteName()
            case "3":
                appendScore()
            case "4":
                deleteScore()
            case "5":
                averageScore()
            case "x","X":
                programRun = false
            default:
                print("뭔가 입력이 잘못되었습니다. 1 ~ 5 사이의 숫자 혹은 X를 입력해주세요\n")
            
            
        }
    }

}
else {

    while programRun {
        
        print("원하는 기능을 입력해주세요\n")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4:성적삭제, 5: 평점보기, X: 종료\n")

        let input = readLine()
        switch input {
            case "1":
                appendName()
            case "2":
                deleteName()
            case "3":
                appendScore()
            case "4":
                deleteScore()
            case "5":
                averageScore()
            case "x","X":
                programRun = false
            default:
                print("뭔가 입력이 잘못되었습니다. 1 ~ 5 사이의 숫자 혹은 X를 입력해주세요\n")
        }
    }
    saveData(names: studentNames, scores: studentScores)

}
