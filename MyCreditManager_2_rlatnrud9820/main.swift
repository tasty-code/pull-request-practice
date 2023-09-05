//
//  main.swift
//  MyCreditManager_2_rlatnrud9820
//
//  Created by 김수경 on 2023/08/16.
//

import Foundation


enum WrongInput: Error, CustomDebugStringConvertible {

    case menuWrongInput
    case commonWrongInput
    case duplicatedInput(name: String)
    case nonExistentInput(name: String)
    case nonExistentSubject(name: String, subject: String)

    var debugDescription: String {
        switch self {
        case .menuWrongInput:
            return "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        case .commonWrongInput:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .duplicatedInput(let name):
            return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .nonExistentInput(let name):
            return "\(name) 학생을 찾지 못했습니다."
        case .nonExistentSubject(let name, let subject):
            return "\(name) 학생의 \(subject) 성적을 찾지 못했습니다."
        default:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        }
    }
    
}


struct Subject : Codable{
    let subject: String
    var grade: String
}

struct Student : Codable{
    var data: [String: [Subject]]
}


class MyCreditManager{
    var isRunning = true
    var student: [String: [Subject]] = [:]

    
    func run(){
        
        let stu: Student = loadJsonFile() ?? Student(data: [:])
        student = stu.data
        

        while (isRunning){
            switch self.menu() {
            case "1":
                do { try addStudent() } catch {
                    print(error)
                }
            case "2":
                do { try deleteStudent() } catch {
                    print(error)
                }
            case "3":
                do { try changeGrade() } catch {
                    print(error)
                }
            case "4":
                do { try deleteGrade() } catch {
                    print(error)
                }
            case "5":
                do { try viewGrade() } catch {
                    print(error)
                }
            case "X":
                exitProgram()
            default:
                do { try ErrorMessage() } catch{
                    print(error)
                }
            }
        }
    }
    
    
    private func menu() -> String {
        print("원하는 기능을 입력해주세요.\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        return readLine() ?? "0"
    }
    
    private func addStudent() throws {
        print("추가할 학생의 이름을 입력해주세요")
        
        guard let name = readLine(),
              !name.isEmpty, name.trimmingCharacters(in: [" "]).count != 0 else {
                  throw WrongInput.commonWrongInput
              }
        if let _ = student[name]{
            throw WrongInput.duplicatedInput(name: name)
        }
        
        student[name] = [Subject]()
        print("\(name) 학생을 추가했습니다.")
    }
    
    private func deleteStudent() throws {
        print("삭제할 학생의 이름을 입력해주세요")
        
        guard let name = readLine(),
              !name.isEmpty, name.trimmingCharacters(in: [" "]).count != 0 else {
                  throw WrongInput.commonWrongInput
              }
        
        if student[name] == nil {
            throw WrongInput.nonExistentInput(name: name)
        }
        
        student[name] = nil
        print("\(name) 학생을 삭제하였습니다.")
    }
        
    private func changeGrade() throws {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재한다면 기존 점수가 갱신됩니다.")
        
        guard let input = readLine(),
              !input.isEmpty, input.trimmingCharacters(in: [" "]).count != 0, input.split(separator: " ").count == 3 else {
                  throw WrongInput.commonWrongInput
              }
        
        let inputArr = input.split(separator: " ").map { String($0) }
        let (name, subject, grade) = (inputArr[0], inputArr[1], inputArr[2])
        if student[name] == nil {
            throw WrongInput.nonExistentInput(name: name)
        }
        
        if let hadSubject = student[name]?.firstIndex(where: { $0.subject == subject }) {
            student[name]?.remove(at: hadSubject)
            student[name]?.append(Subject(subject: subject, grade: grade))
        }else{
            student[name]?.append(Subject(subject: subject, grade: grade))
        }
        
        print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
    }
    
    private func deleteGrade() throws{
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
        
        guard let input = readLine(),
              !input.isEmpty, input.trimmingCharacters(in: [" "]).count != 0, input.split(separator: " ").count == 2 else {
                  throw WrongInput.commonWrongInput
              }
        let inputArr = input.split(separator: " ").map { String($0) }
        let (name, subject) = (inputArr[0], inputArr[1])
        
        if student[name] == nil {
            throw WrongInput.nonExistentInput(name: name)
        }else{
            if let hadSubject = student[name]?.firstIndex(where: { $0.subject == subject }) {
                student[name]?.remove(at: hadSubject)
                print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            }else{
                throw WrongInput.nonExistentSubject(name: name, subject: subject)
            }
        }
    }
    
    private func viewGrade() throws {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        guard let name = readLine(),
              !name.isEmpty, name.trimmingCharacters(in: [" "]).count != 0 else {
                  throw WrongInput.commonWrongInput
              }
        if student[name] == nil {
            throw WrongInput.nonExistentInput(name: name)
        }

        for subj in student[name]! {
            print("\(subj.subject): \(subj.grade)")
        }
        
        print("평점: \(String(format: "%.2f", gradeCalculator(grade: student[name]!)) )")
    }
    
    private func exitProgram(){
        isRunning = false
        saveJsonData(data: Student(data: student))
        print("프로그램을 종료합니다...")
    }
    
    private func ErrorMessage() throws{
        throw WrongInput.menuWrongInput
    }
 
    func gradeCalculator(grade: [Subject]) -> Double {
        let score = ["A+": 4.5, "A": 4.0, "B+": 3.5, "B": 3.0, "C+": 2.5, "C": 2.0, "D+": 1.5, "D": 1.0]
        return grade.map{ score[$0.grade] ?? 0.0 }.reduce(0.0, +) / Double(grade.count)
    }
    
    

    
    func saveJsonData(data:Student) {
            let jsonEncoder = JSONEncoder()
            
            do {
                let encodedData = try jsonEncoder.encode(data)
                
                guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                let fileURL = documentDirectoryUrl.appendingPathComponent("SeSAC_rlatnrud9820.json")
                
                do {
                    try encodedData.write(to: fileURL)
                }
                catch let error as NSError {
                    print(error)
                }
                
            } catch {
                print(error)
            }
            
        }
    
    
    func loadJsonFile() -> Student?{
            let jsongDecoder = JSONDecoder()
            
            do {
                guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
                
                let fileURL = documentDirectoryUrl.appendingPathComponent("SeSAC_rlatnrud9820.json")
                
                do {
                    if !FileManager.default.fileExists(atPath: fileURL.path) {
                        try FileManager.default.createFile(atPath: fileURL.pathExtension, contents: nil)
                        return nil
                    }
                } catch {
                    print("create folder error. do something")
                }
                
                let jsonData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let decodedStudent = try jsongDecoder.decode(Student.self, from: jsonData)
                return decodedStudent
            }
            catch {
                print(error)
                return nil
            }
        }
}

MyCreditManager().run()
