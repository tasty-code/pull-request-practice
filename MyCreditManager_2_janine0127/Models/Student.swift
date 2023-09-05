//
//  student.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/20.
//

import Foundation

class Student: Hashable, Equatable, Codable {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.name == rhs.name
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
