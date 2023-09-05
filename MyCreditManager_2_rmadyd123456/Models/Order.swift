//
//  Order.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/18.
//

import Foundation

@frozen enum Order: String {
    case addStudent = "1"
    case removeStudent = "2"
    case adjustScore = "3"
    case removeScore = "4"
    case getStatusScore = "5"
    case exitProgram = "X"
}
