//
//  service.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/20.
//

import Foundation


struct ServiceManager {
    private var studentList: [Student:[Grade]] = [:]
    
    mutating func addStudent() {
        print("추가할 학생의 이름을 입력해주세요.")
        guard let input = readLine(), !input.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        let name = checkRegex(input)
        guard !name.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        if studentList.keys.contains(where: { $0.name == name }) {
            print("\(name) 학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            let student = Student(name)
            studentList[student] = []
            print("\(name) 학생을 추가했습니다.")
        }
    }
    
    mutating func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        guard let input = readLine(), !input.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        
        let target = checkRegex(input)
        guard !target.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        
        if let studentToRemove = getTargetStudent(target) {
            studentList.removeValue(forKey: studentToRemove)
            print("\(target) 학생을 삭제하였습니다.")
        } else {
            print("\(target) 학생을 찾지 못했습니다.")
        }
    }
    
    
    mutating func addGrade() {
        print(
        """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """)
        
        guard let input = readLine(),
              !input.isEmpty
        else {
            print(Alert.wrong.message)
            return
        }
        
        let splited = input.split(separator: " ").map { checkRegex(String($0)) }
        guard splited.count == 3 else {
            print(Alert.wrong.message)
            return
        }
        
        let (studentName, subjectVal, gradeVal) = (splited[0],splited[1].capitalized,splited[2])
        
        guard let letterGrade = LetterGrade(rawValue: gradeVal) else {
            print("존재하지 않는 점수입니다.")
            return
        }
        
        guard let target = getTargetStudent(studentName) else {
            print("\(studentName) 학생이 존재하지 않습니다.")
            return
        }
        
        let newGrade = Grade(subject: subjectVal, value: letterGrade)
        
        if let gradeList = studentList[target], let index = gradeList.firstIndex(where: { $0.subject == subjectVal }) {
            studentList[target]?[index].value = letterGrade
        } else {
            studentList[target]?.append(newGrade)
        }
        
        print("\(studentName) 학생의 \(subjectVal) 과목이 \(letterGrade.rawValue)로 추가(변경)되었습니다.")
    }
    
    mutating func removeGrade() {
        print(
        """
        성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift
        """
        )
        guard let input = readLine(), !input.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        
        let splited = input.split(separator: " ").map { checkRegex(String($0)) }
        guard splited.count == 2 else {
            print(Alert.wrong.message)
            return
        }
        let (studentName, subjectVal) = (splited[0], splited[1].capitalized)
        
        guard let target = getTargetStudent(studentName) else {
            print("\(studentName) 학생을 찾지 못했습니다.")
            return
        }
        
        studentList[target]?.removeAll { $0.subject == subjectVal }
        
        print("\(studentName) 학생의 \(subjectVal) 과목의 성적이 삭제되었습니다.")
        
    }
    
    func getGradeAll() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        guard let input = readLine(), !input.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        
        let name = checkRegex(input)
        guard !name.isEmpty else {
            print(Alert.wrong.message)
            return
        }
        
        guard let target = getTargetStudent(name) else {
            print("\(name) 학생을 찾지 못했습니다.")
            return
        }
        guard let gradeList = studentList[target], gradeList.count > 0 else {
            print("\(name) 학생의 성적이 존재하지 않습니다.")
            return
        }
        let avg = ((gradeList.map{ $0.value.point }.reduce(0.0) { $0 + $1 } / Double(gradeList.count)) * 100).rounded() / 100
        
        print("이름: \(name)")
        gradeList.forEach {
            print($0.subject,":", $0.value.rawValue)
        }
        print("평점: \(avg) ")
        return
    }
}

extension ServiceManager {
    func checkRegex(_ str:String) -> String {
        let regexPattern = "[^a-zA-Z0-9+]"
        let res = str.replacingOccurrences(of: regexPattern, with: "", options: .regularExpression)
        return res
    }
    
    func getTargetStudent(_ target: String) -> Student? {
        return studentList.keys.first { $0.name == target }
    }
    
    func getGradeOfSubject(_ subject: String, for student: Student) -> Grade? {
        return studentList[student]?.first { $0.subject == subject }
    }
}

extension ServiceManager {
    private var filePath: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("MyCreditManagerData.json")
    }
    
    func saveData() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(studentList)
            try data.write(to: filePath)
        } catch {
            print("저장 실패: \(error.localizedDescription)")
        }
    }
    
    mutating func loadData() {
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            studentList = try decoder.decode([Student:[Grade]].self, from: data)
        } catch {
            print("불러오기 실패: \(error.localizedDescription)")
        }
    }
}
