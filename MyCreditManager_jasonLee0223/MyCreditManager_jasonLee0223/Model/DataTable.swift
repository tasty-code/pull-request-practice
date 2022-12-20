//
//  DataTable.swift
//  MyCreditManager_jasonLee0223
//
//  Created by 이건행 on 2022/12/06.
//

import Foundation

struct DataTable: Equatable {
    var name: String
    var subject: String
    var grade: Grade

    init(name: String, subject: String, grade: Grade) {
        self.name = name
        self.subject = subject
        self.grade = grade
    }
}
