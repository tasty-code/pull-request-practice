//
//  main.swift
//  MyCreditManager_2_rarlala2015
//
//  Created by Rarla on 2023/08/15.
//

import Foundation

var userOption: String?
let store = UserDefaults.standard
let localStudentData = store.dictionary(forKey: "studentData") as? [String: [String: String]] ?? [:]
var studentData: [String : [String: String]] = localStudentData

var gradeType = ["A+" : 4.5, "A0": 4, "B+": 3.5, "B0": 3, "C+": 2.5, "C0": 2, "D+": 1.5, "D0": 1, "F": 0]

func selectOption() {
  print("원하는 기능을 입력해주세요 \n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
  userOption = readLine()
  
  guard let option = userOption else {
    return inputError("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
  }
  
  switch option {
  case "X":
    exit()
  case "1":
    addStudent()
  case "2":
    deleteStudent()
  case "3":
    addAndUpdateGrade()
  case "4":
    deleteGrade()
  case "5":
    viewRatings()
  default:
    inputError("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    break
  }
  
  if option != "X" && 1...5 ~= Int(option)! {
    selectOption()
  }
}

func addStudent() {
  print("추가할 학생의 이름을 입력해주세요")
  let studentName = readLine()
  
  guard let name = (studentName?.trimmingCharacters(in: .whitespaces) != "" ? studentName : nil) else {
    return inputError()
  }
  
  if studentData[name] != nil {
    return inputError("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
  }
  
  studentData[name] = [:]
  store.set(studentData, forKey: "studentData")
  print("\(name) 학생을 추가했습니다.")
}

func deleteStudent() {
  print("삭제할 학생의 이름을 입력해주세요")
  let studentName = readLine()
  
  guard let name = (studentName?.trimmingCharacters(in: .whitespaces) != "" ? studentName : nil) else {
    return inputError()
  }
  
  if studentData[name] == nil {
    return inputError("\(name) 학생을 찾지 못했습니다.")
  }
  
  studentData.removeValue(forKey: name)
  store.set(studentData, forKey: "studentData")
  print("\(name) 학생을 삭제하였습니다.")
}

func addAndUpdateGrade() {
  print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요. \n입력예) Mickey Swift A+ \n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
  let inputData = readLine()
  guard let splitData = inputData?.split(separator: " ") else {
    return inputError()
  }
  
  if splitData.count != 3 { return inputError() }
  if studentData[String(splitData[0])] == nil || gradeType[String(splitData[2])] == nil {
    return inputError()
  }
  
  let studentName = String(splitData[0])
  let subject = String(splitData[1])
  let grade = String(splitData[2])
  
  var student = studentData[studentName]!
  student.updateValue(grade, forKey: subject)
  studentData.updateValue(student, forKey: studentName)
  store.set(studentData, forKey: "studentData")
  
  print("\(studentName) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
}

func deleteGrade() {
  print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요 \n입력예) Mickey Swift")
  let inputData = readLine()
  guard let splitData = inputData?.split(separator: " ") else { return inputError() }
  if splitData.count != 2 { return inputError() }
  
  if studentData[String(splitData[0])] == nil {
    return inputError("\(String(splitData[0])) 학생을 찾지 못했습니다.")
  }
  
  let studentName = String(splitData[0])
  let subject = String(splitData[1])
  
  var student = studentData[studentName]!
  student.removeValue(forKey: subject)
  studentData.updateValue(student, forKey: studentName)
  store.set(studentData, forKey: "studentData")
  
  print("\(studentName) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
}

func viewRatings() {
  print("평점을 알고싶은 학생의 이름을 입력해주세요")
  let studentName = readLine()
  
  guard let name = (studentName?.trimmingCharacters(in: .whitespaces) != "" ? studentName : nil) else {
    return inputError()
  }
  
  guard let student = studentData[name] else {
    return inputError("\(name) 학생을 찾지 못했습니다.")
  }
  
  if student.count == 0 {
    return inputError("\(name) 학생의 출력할 성적 데이터가 없습니다.")
  }
  
  var score = 0.0
  for data in student {
    print("\(data.0): \(data.1)")
    score += Double(gradeType[data.1]!)
  }
  
  let grade = String(format: "%.2f", score / Double(student.count))
  print("평점 : \(grade)")
}

func exit() {
  print("프로그램을 종료합니다...")
}

func inputError(_ message: String = "입력이 잘못되었습니다. 다시 확인해주세요.") {
  print(message)
  selectOption()
}

// start
selectOption()
