//
//  CreditManager.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

/// creditManager의 DataFile 관련 정보들
enum DataFile {
    /// 데이터가 저장되고 로드하는 json 파일 이름
    static let name = "data.json"
    /// 파일이 저장될 Directory
    static let directory: String = FileManager.default.currentDirectoryPath
    static let pathString = DataFile.directory.appending(DataFile.name)
    static var pathUrl: URL {
        if #available(macOS 13.0, *) {
            return URL(filePath: DataFile.directory.appending(DataFile.name))
        } else {
            return URL(fileURLWithPath: DataFile.directory.appending(DataFile.name))
        }
    }
}

final class CreditManager {
    /// CreditManager - singleton
    static let shared = CreditManager()
    private init() { }
    
    /// CreditManager의 현재 status
    private var status: Status = .start
    /// CreditManager에 등록된 Student의 List
    private var students = [Student]()
    
    /// 1. 저장된 데이터 로드
    /// 2. 프로그램 상태에 맞는 info 메세지 출력
    /// 3. input 처리 및 실행
    /// 4. error발생 시 설명 출력
    ///     - 종료 error 시 데이터 저장 및 프로그램 종료
    func run() {
        loadData()
        while true {
            do {
                IOManager.writeMessage(status.infoMessage)
                let input = try IOManager.getInput(isStartStatus: status == .start)
                let parsedInput = try parse(input: input)
                try doWith(parsedInput)
            } catch {
                IOManager.writeMessage(error.localizedDescription, type: .error)
                switch error {
                case CMError.quitProgram:
                    saveData()
                    return
                default:
                    status = .start
                }
            }
        }
    }
    
    /// status 별 input parse
    private func parse(input: String) throws -> ParsedInput {
        guard let parsedInput = status.parse(input: input) else {
            throw status == .start ? CMError.invalidStartInput : IOError.wrongInput
        }
        return parsedInput
    }
    
    
    /// 입력과 상태에 따라 CreditManager 작동 분기
    ///
    /// - result Infomation이 있다면 출력한다
    /// - 실행 후 credit manager의 status는 start로 변경
    private func doWith(_ input: ParsedInput) throws {
        do {
            switch self.status {
            case .start:
                try start(input)
                return
            case .addStudent:
                try add(student: input)
            case .deleteStudent:
                try delete(student: input)
            case .addScore:
                try add(score: input)
            case .deleteScore:
                try delete(score: input)
            case .showScoreAverage:
                try show(score: input)
            case .exit:
                return
            }
        } catch {
            throw error
        }
        if let resInfo = status.resMessage(input: input) {
            IOManager.writeMessage(resInfo, type: .reaction)
        }
        status = .start
    }
}

//MARK: - Start

extension CreditManager {
    /// 입력에 따라 credit manager의 status 변경
    private func start(_ input: ParsedInput) throws {
        guard let nextStatus = input[0] as? Status else {
            throw CMError.invalidStartInput
        }
        guard nextStatus != .exit else {
            throw CMError.quitProgram
        }
        guard [Status.start, Status.addStudent].contains(nextStatus) || false == students.isEmpty else {
            throw CMError.emptyStudents
        }
        self.status = nextStatus
    }
}

//MARK: - AddStudent

extension CreditManager {
    /// 입력받은 학생을 students에 추가
    ///
    /// Error occurs when
    /// - 입력받은 학생이 이미 존재
    private func add(student input: ParsedInput) throws {
        guard let name = input[0] as? String else {
            throw IOError.wrongInput
        }
        guard false == exists(student: name) else {
            throw CMError.studentAleadyExists(name: name)
        }
        let student = Student(name: name)
        students.append(student)
    }
    
    /// 학생이 등록되어 있다면 true
    private func exists(student name: String) -> Bool {
        return students.contains { $0.name == name }
    }
}

//MARK: - Delete Student

extension CreditManager {
    /// 입력받은 학생을 students에서 삭제
    ///
    /// Error occurs when
    /// - 등록된 학생이 0명
    /// - 입력받은 학생이 존재하지 않음
    private func delete(student input: ParsedInput) throws {
        guard false == students.isEmpty  else {
            throw CMError.emptyStudents
        }
        guard let name = input[0] as? String else {
            throw IOError.wrongInput
        }
        guard exists(student: name) else {
            throw CMError.studentNotFound(name: name)
        }
        students.removeAll { $0.name == name }
    }
}


//MARK: - Add Score

extension CreditManager {
    /// 등록된 학생에 course, score 정보 추가
    ///
    /// Error occurs when
    /// - 입력받은 학생이 존재하지 않음
    private func add(score input: ParsedInput) throws {
        guard let name = input[0] as? String,
              let course = input[1] as? String,
              let score = input[2] as? Score else {
            throw IOError.wrongInput
        }
        guard let student = students.first(where: { $0.name == name}) else {
            throw CMError.studentNotFound(name: name)
        }
        student.update(course: course, score: score)
    }
}

//MARK: - Delete Score

extension CreditManager {
    /// 등록된 학생의 course 정보 삭제
    ///
    /// Error occurs when
    /// - 입력받은 학생이 존재하지 않음
    /// - 학생 정보에 해당 과목이 등록되어 있지 않음
    private func delete(score input: ParsedInput) throws {
        guard let name = input[0] as? String,
              let course = input[1] as? String else {
            throw IOError.wrongInput
        }
        guard let student = students.first(where: { $0.name == name}) else {
            throw CMError.studentNotFound(name: name)
        }
        guard student.remove(course: course) != nil else {
            throw CMError.courseNotFound(name: name, course: course)
        }
    }
}

//MARK: - Show Average Score

extension CreditManager {
    /// 등록된 학생의 전체 과목과 평점 확인
    ///
    /// Error occurs when
    /// - 입력받은 학생이 존재하지 않음
    /// - 학생 정보에 등록된 과목이 없음
    private func show(score input: ParsedInput) throws {
        guard let name = input[0] as? String else {
            throw IOError.wrongInput
        }
        guard let student = students.first(where: { $0.name == name}) else {
            throw CMError.studentNotFound(name: name)
        }
        guard false == student.scores.isEmpty else {
            throw CMError.emptyCourse(name: name)
        }
        IOManager.writeMessage(student.allScoresDescription)
    }
}


extension CreditManager {
    /// students property를 json 파일에 저장
    private func saveData() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(StudentList(students: students))
            
            if false == FileManager.default.fileExists(atPath: DataFile.pathString) {
                FileManager.default.createFile(atPath: DataFile.pathString, contents: nil)
            }
            
            try data.write(to: DataFile.pathUrl)
            let names = students.map {$0.name}
            
            IOManager.writeMessage(Info.Data.saved(names: names), type: .reaction)
        } catch {
            IOManager.writeMessage(error.localizedDescription, type: .error)
        }
    }
    
    /// json 파일 데이터를 students property에 불러오기
    private func loadData() {
        guard let data = try? Data(contentsOf: DataFile.pathUrl),
              let studentList = try? JSONDecoder().decode(StudentList.self, from: data) else {
            IOManager.writeMessage(Info.Warning.failedToLoadData, type: .error)
            return
        }
        students = studentList.students
        
        let names = students.map {$0.name}
        IOManager.writeMessage(Info.Data.loaded(names: names), type: .reaction)
    }
}
