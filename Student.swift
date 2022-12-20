//
//  Student.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

final class Student: Codable {
    let name: String
    private(set) var scores = [String:Score]()
    
    var isCourseEmpty: Bool {
        return scores.isEmpty
    }
    
    var averageScore: Float {
        let total = scores.values.reduce(0) { $0 + $1.rawValue }
        return total/Float(scores.values.count)
    }
    
    var allScoresDescription: String {
        var res = ""
        for item in scores {
            res += "\(item.key): \(item.value.description)\n"
        }
        return res + "평점: " + String(format: "%.2f", averageScore)
    }
    
    init(name: String) {
        self.name = name
    }
    
    func update(course: String, score: Score) {
        scores.updateValue(score, forKey: course)
    }
    
    func remove(course: String) -> Score? {
        return scores.removeValue(forKey: course)
    }
}

//MARK: - Student DataStructure

struct StudentList: Codable {
    let students: [Student]
}
