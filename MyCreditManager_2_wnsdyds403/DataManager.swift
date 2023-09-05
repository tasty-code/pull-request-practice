//
//  DataManager.swift
//  MyCreditManager_2_wnsdyds403
//
//  Created by 지준용 on 2023/08/15.
//

import Foundation

struct Student: Codable {
    var subject: String
    var grade: String
}

final class DataManager {
    
    // MARK: - Property

    private var dataKey = "data"
    typealias dictionaryString = [String: [Student]]

    // MARK: - Create

    func saveData(of students: dictionaryString) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(students)
            UserDefaults.standard.set(encodedData, forKey: dataKey)
        } catch {
            print(error)
        }
    }

    // MARK: - Read

    func loadData(closure: (dictionaryString) -> ()) {
        guard let encodedData = UserDefaults.standard.data(forKey: dataKey) else { return }
        
        do {
            let decoder = JSONDecoder()
            let students = try decoder.decode(dictionaryString.self, from: encodedData)
            closure(students)
        } catch {
            print(error)
        }
    }
}
