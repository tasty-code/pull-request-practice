//
//  main.swift
//  MyCreditManager_2_ing0401
//
//  Created by 김진웅 on 2023/08/19.
//

import Foundation

struct Student: Codable {
    let name: String
    var grades: [String: String] // [과목: 성적]을 저장하는 딕셔너리
}

final class Program {
    private var students: [Student] = [] // Student(name: "bello", grades: [:])
    
    func run() {
        loadData() // 프로그램이 동작하게 되면 데이터를 불러온다.
        var exit = false
        
        while !exit {
            printMenu()
            
            let choice = inputFunc()
            switch choice {
            case "1" : addStudent()
            case "2" : deleteStudent()
            case "3" : addOrModifyGrade()
            case "4" : deleteGrade()
            case "5" : viewRatings()
            case "X" :
                saveData()
                exit = true
                print("프로그램을 종료합니다...")
                
            default: print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            }
        }
    }
    
    private func printMenu() {
        print("원하는 기능을 입력해주세요")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    }
    
    private func inputFunc() -> String {
        let input = readLine()
        guard let userInput = input else { return "" }
        return userInput
    }
    
    private func addStudent() { // 1: 학생추가
        print("추가할 학생의 이름을 입력해주세요")
        
        guard let name = readLine(), !name.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if students.contains(where: { $0.name == name }) {
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            students.append(Student(name: name, grades: [:]))
            print("\(name) 학생을 추가했습니다.")
        }
    }
    
    private func deleteStudent() { // 2: 학생삭제
        print("삭제할 학생의 이름을 입력해주세요")
        
        guard let name = readLine(), !name.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        if let index = students.firstIndex(where: { $0.name == name }) {
            students.remove(at: index)
            print("\(name) 학생을 삭제하였습니다.")
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    private func addOrModifyGrade() { // 3: 성적추가(변경)
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        
        guard let input = readLine(), !input.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let components = input.components(separatedBy: " ")
        guard components.count == 3 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = components[0]
        let subject = components[1]
        let grade = components[2].uppercased() // 만약 성적이 소문자로 입력됐을 때, 대문자로 변환 처리
        
        if let index = students.firstIndex(where: { $0.name == name }) {
            students[index].grades[subject] = grade
            print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    private func deleteGrade() { // 4: 성적삭제
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        
        guard let input = readLine(), !input.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let components = input.components(separatedBy: " ")
        guard components.count == 2 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = components[0]
        let subject = components[1]
        
        guard let index = students.firstIndex(where: { $0.name == name }) else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        
        if students[index].grades[subject] != nil {
            students[index].grades.removeValue(forKey: subject)
            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
        } else {
            print("\(name) 학생의 \(subject) 과목을 찾지 못했습니다.")
        }
    }
    
    private func viewRatings() { // 5: 평점보기
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        guard let name = readLine(), !name.isEmpty else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        guard let student = students.first(where: { $0.name == name }) else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        
        for (subject, grade) in student.grades {
            print("\(subject): \(grade)")
        }
        
        let rating = calculateRating(for: student)
        if rating == "N/A" {
            print("\(name) 학생의 성적이 없어 평점을 확인할 수 없습니다.")
            return
        }
        
        print("평점 : \(rating)")
    }
    
    private func calculateRating(for student: Student) -> String { // 평점 계산 메서드
        var total = 0.0
        var subjectCount = 0
        
        for (_, grade) in student.grades {
            switch grade {
            case "A+": total += 4.5
            case "A0": total += 4.0
            case "B+": total += 3.5
            case "B0": total += 3.0
            case "C+": total += 2.5
            case "C0": total += 2.0
            case "D+": total += 1.5
            case "D0": total += 1.0
            case "F": total += 0.0
            default: break
            }
            subjectCount += 1
        }
        
        if subjectCount > 0 {
            let result = total / Double(subjectCount)
            
            let rating: String
            switch result {
            case _ where result.truncatingRemainder(dividingBy: 1) == 0 :
                rating = String(format: "%.0f", result)
            case _ where (result * 10.0).truncatingRemainder(dividingBy: 1) == 0 :
                rating = String(format: "%.1f", result)
            default:
                rating = String(format: "%.2f", result)
            }
            return rating
        } else {
            return "N/A"
        }
    }
    
    private func saveData() { // 종료 시 데이터를 저장
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(students) else { return }
        do {
            try data.write(to: dataFileURL())
            print("데이터가 저장되었습니다. 위치는 \(dataFileURL().path)")
        } catch {
            print("오류 발생 : \(error.localizedDescription)")
        }
    }
    
    private func loadData() { // 프로그램 시작 시 데이터를 가져오기
        guard let data = try? Data(contentsOf: dataFileURL()) else { return }
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([Student].self, from: data) {
            students = decodedData
        }
    }
    
    private func dataFileURL() -> URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("ing0401_data.json")
    }
}

let program = Program()
program.run()
