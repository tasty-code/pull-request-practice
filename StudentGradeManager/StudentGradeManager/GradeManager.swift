//
//  GradeManager.swift
//  StudentGradeManager
//
//  Created by 조용현 on 2022/12/20.
//

import Foundation

class GradeManager {
    
    private let gradeManageSystem = GradeManagerSystem()
    
    func run() {
        while !gradeManageSystem.isDone {
            do {
                let menuInput = try gradeManageSystem.receiveMenuInput()
                gradeManageSystem.performMenuAction(menuInput: menuInput)
            } catch {
                print(error)
            }
        }
    }
}
