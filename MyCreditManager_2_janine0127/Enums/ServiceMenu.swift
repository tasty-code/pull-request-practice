//
//  ServiceMenu.swift
//  MyCreditManager_2_janine0127
//
//  Created by Janine on 2023/08/21.
//

import Foundation

enum Menu:String, Codable {
    case studentAdder = "1"
    case studentRemover = "2"
    case GradeUpdater = "3"
    case GradeRemover = "4"
    case Average = "5"
    case Exit = "X"
    case ExitLowerCase = "x"
}
