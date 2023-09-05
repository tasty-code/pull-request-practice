//
//  Student.swift
//  MyCreditManager_2_01234a
//
//  Created by Wonji Ha on 2023/08/16.
//

import Foundation

struct Student: Codable {
    var name: String
    var grade: [String: Double] = [:]
}
