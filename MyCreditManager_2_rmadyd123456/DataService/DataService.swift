//
//  DataService.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/15.
//

import Foundation

class DataService {
    var studentDatabase: StudentDatabase = StudentDatabase()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        guard let data = LocalFileManager.shared.fetchData(),
              let studentDatabase = decodeToDatabase(with: data)
        else { self.studentDatabase = StudentDatabase(); return }
        self.studentDatabase = studentDatabase
    }
    
    private func decodeToDatabase(with data: Data) -> StudentDatabase? {
        try? JSONDecoder().decode(StudentDatabase.self, from: data)
    }
    
    private func encodeToData(with studentDatabase: StudentDatabase) -> Data? {
        try? JSONEncoder().encode(studentDatabase)
    }
}

// MARK: Internal Methods
extension DataService {
    func addStudent(name: String) {
        studentDatabase[name] = [:]
    }
    
    func removeStudent(name: String) {
        studentDatabase[name] = nil
    }
    
    func adjustScore(name: String, subject: String, grade: String) {
        studentDatabase[name]?[subject] = grade.convertToGrade()
    }
    
    func removeScore(name: String, subject: String) {
        studentDatabase[name]?[subject] = nil
    }
    
    func saveStudentDatabase() {
        guard let data = encodeToData(with: self.studentDatabase) else { return }
        LocalFileManager.shared.saveData(data: data)
    }
}
