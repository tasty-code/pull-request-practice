//
//  Functions.swift
//  MyCreditManager_2_01234a
//
//  Created by Wonji Ha on 2023/08/15.
//
/// 각 메뉴에 대한 기능 코드입니다.

import Foundation

class Functions {
    var students: [Student] = []
    
    // MARK: - 학생 추가 함수
    func createStudent() {
        print(Msg.CreateStudent.addMsg)
        let name = readLine()!
        if name.isEmpty || name.checkValue(value: name) {
            print(Msg.Input.inputError)
        }
        else if students.contains(where: { $0.name == name }) {
            print("\(name)", Msg.CreateStudent.errorMsg)
        }
        else {
            students.append(Student(name: name, grade: [:]))
            print("\(name)", Msg.CreateStudent.addSuccess)
            saveStudents()
        }
    }
    
    // MARK: - 학생 삭제 함수
    func deleteStudent() {
        print(Msg.DeleteStudent.delMsg)
        let name = readLine()!
        if name.isEmpty || name.checkValue(value: name) {
            print(Msg.Input.inputError)
        }
        else if let index = students.firstIndex(where: { $0.name == name }) {
            students.remove(at: index)
            print("\(name)", Msg.DeleteStudent.delSuccess)
            saveStudents()
        }
        else {
            print("\(name)", Msg.ErrorMsg.noStudent)
        }
    }
    
    // MARK: - 성적추가(변경) 함수
    func updateGrade() {
        print(Msg.UpdateGrade.addMsg)
        let grade = readLine()!.components(separatedBy: " ").map { String($0) }
        
        if grade.isEmpty || grade.count < 3 {
            print(Msg.Input.inputError)
            return
        }
        
        let name = grade[0]
        let subject = grade[1]
        /// uppercased() 소문자를 대문자로 치환
        guard let score = Grade.init(subject: subject).gradeRating[grade[2].uppercased()] else { print(Msg.UpdateGrade.errorMsg); return }
        
        if students.filter({ $0.name == name }).isEmpty {
            print("\(name)", Msg.ErrorMsg.noStudent)
            return
        }
        
        else if let gradeIdx = students.map({ $0.name }).firstIndex(of: name) {
            students[gradeIdx].grade.updateValue(score, forKey: subject)
            print("\(name) 학생의 \(subject) 과목이 \(grade[2].uppercased())로 추가(변경)되었습니다.")
            saveStudents()
        }
    }
    
    // MARK: - 성적삭제 함수
    func deleteGrade() {
        print(Msg.DeleteGrade.delMsg)
        let grade = readLine()!.components(separatedBy: " ").map { String($0) }
        
        if grade.isEmpty || grade.count < 2 {
            print(Msg.Input.inputError)
            return
        }
        let name = grade[0]
        let subject = grade[1]
        
        guard !students.filter({ $0.name == name }).isEmpty else {
            print("\(name)", Msg.ErrorMsg.noStudent)
            return
        }
        
        if let gradeIdx = students.map({ $0.name }).firstIndex(of: name) {
            guard students[gradeIdx].grade[subject] != nil else {
                print("\(subject)", Msg.DeleteGrade.errorMsg)
                return
            }
            students[gradeIdx].grade.removeValue(forKey: subject)
            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            saveStudents()
        }
    }
    
    // MARK: - 평점보기 함수
    func readGrade() {
        print(Msg.ReadGrade.msg)
        let name = readLine()!
        
        if name.isEmpty || name.checkValue(value: name) {
            print(Msg.Input.inputError)
            return
        }
        
        else if students.filter({ $0.name == name }).isEmpty {
            print("\(name)", Msg.ErrorMsg.noStudent)
            return
        }
        
        else if let gradeIdx = students.map({ $0.name }).firstIndex(of: name) {
            if students[gradeIdx].grade.count == 0 {
                print(Msg.ReadGrade.errorMsg)
                return
            }
        }
        
        if let gradeIdx = students.map({ $0.name }).firstIndex(of: name) {
            var sumScore: Double = 0.0
            for i in students[gradeIdx].grade {
                let grade = Grade.init(subject: "").gradeRating.first(where: { $0.value == i.value })
                let gradeKey = grade?.key
                let convertGrade = gradeKey ?? ""
                print("\(i.key): \(convertGrade)")
                sumScore += i.value
            }
            let average = sumScore / Double(students[gradeIdx].grade.count)
            print("평점 : ", String(format: "%.2f", average))
        }
    }
    
    // MARK: - 현재 학생의 성적 정보 저장 함수
    func saveStudents() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(students) {
            UserDefaults.standard.setValue(encoded, forKey: "students")
        }
    }
    
    // MARK: - 저장된 학생의 성적 정보를 압축 해제 하여 불러오는 함수
    func loadStudents() {
        if let readStudents = UserDefaults.standard.object(forKey: "students") as? Data {
            let decoder = JSONDecoder()
            if let saveData = try? decoder.decode([Student].self, from: readStudents) {
                students = saveData
            }
        }
    }
        
    // MARK: - 성적 정보 저장 및 프로그램 종료 함수
    func exit() {
        loadStudents()
        print(Msg.Exit.msg)
        run = false
    }
}
