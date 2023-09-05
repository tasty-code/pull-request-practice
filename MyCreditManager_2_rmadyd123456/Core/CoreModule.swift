//
//  CoreModule.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/14.
//

import Foundation

final class CoreModule {
    private let dataService: DataService = DataService()
    
    private var db: StudentDatabase { dataService.studentDatabase }
    
    func run() {
        while true {
            do {
                let order = try getUserOrder()
                try executeOrder(order)
            } catch let error {
                print(error)
            }
        }
    }
}

// MARK: Interface Methods
extension CoreModule {
    private func getUserOrder() throws -> Order {
        print(InterfaceScript.Menu.selectMenu.description)
        
        guard let input = readLine(), let order = Order(rawValue: input) else { throw InterfaceScript.Failure.wrongMenuSelected }
        
        return order
    }
    
    private func executeOrder(_ order: Order) throws {
        switch order {
        case .addStudent: try addStudent()
        case .removeStudent: try removeStudent()
        case .adjustScore: try adjustScore()
        case .removeScore: try removeScore()
        case .getStatusScore: try getStatusScore()
        case .exitProgram: exitProgram()
        }
    }
    
    private func addStudent() throws {
        print(InterfaceScript.AddStudent.readLineStudentName.description)
        
        guard let name = readLine(), name.isEmpty == false else { throw InterfaceScript.Failure.wrongOrderInput }
        
        guard db.keys.contains(name) == false else { throw InterfaceScript.Failure.duplicatedStudentName(name: name) }
        dataService.addStudent(name: name)
        print(InterfaceScript.AddStudent.addStudentSuccess(name: name).description)
    }
    
    private func removeStudent() throws {
        print(InterfaceScript.RemoveStudent.readLineStudentName.description)
        
        guard let name = readLine(), name.isEmpty == false else { throw InterfaceScript.Failure.wrongOrderInput }
        
        guard db.keys.contains(name) else { throw InterfaceScript.Failure.studentNotExist(name: name) }
        dataService.removeStudent(name: name)
        print(InterfaceScript.RemoveStudent.removeStudentSuccess(name: name).description)
    }
    
    private func adjustScore() throws {
        print(InterfaceScript.AdjustScore.readLineScore.description)
        
        guard let input = readLine()?.components(separatedBy: " "),
              input.count == 3,
              GradeType.allCases.map({$0.rawValue}).contains(input[2])
        else { throw InterfaceScript.Failure.wrongOrderInput }
        
        let name = input[0]; let subject = input[1]; let grade = input[2]
        
        guard db.keys.contains(name) else { throw InterfaceScript.Failure.studentNotExist(name: name) }
        dataService.adjustScore(name: name, subject: subject, grade: grade)
        print(InterfaceScript.AdjustScore.adjustScoreSuccess(name: name, subject: subject, grade: grade).description)
    }
    
    private func removeScore() throws {
        print(InterfaceScript.RemoveScore.readLineScore.description)
        
        guard let input = readLine()?.components(separatedBy: " "),
              input.count == 2
        else { throw InterfaceScript.Failure.wrongOrderInput }
        
        let name = input[0]; let subject = input[1]
        
        guard db.keys.contains(name) else { throw InterfaceScript.Failure.studentNotExist(name: name) }
        guard db[name]?.keys.contains(subject) == true else { throw InterfaceScript.Failure.subjectNotExist(name: name, subject: subject) }
        dataService.removeScore(name: name, subject: subject)
        print(InterfaceScript.RemoveScore.removeScoreSuccess(name: name, subject: subject).description)
    }
    
    private func getStatusScore() throws {
        print(InterfaceScript.StatusScore.readLineStudentName.description)
        
        guard let name = readLine(), name.isEmpty == false else { throw InterfaceScript.Failure.wrongOrderInput }
        
        guard db.keys.contains(name) else { throw InterfaceScript.Failure.studentNotExist(name: name) }
        guard let subjects = db[name], subjects.isEmpty == false else { throw InterfaceScript.Failure.statusNotFound }
        
        for subject in subjects.sorted(by: {$0.value.score > $1.value.score}) {
            print("\(subject.key): \(subject.value.rawValue)")
        }
        
        let totalScore: Double = subjects.values.map {$0.score}.reduce(0, +) / Double(subjects.count)
        print(InterfaceScript.StatusScore.statusScoreSuccess(totalScore: totalScore).description)
    }
    
    private func exitProgram() {
        print(InterfaceScript.Menu.exitProgram.description)
        dataService.saveStudentDatabase()
        Darwin.exit(EXIT_SUCCESS)
    }
}
