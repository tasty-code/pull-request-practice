//
//  main.swift
//  MyCreditManager_2_01234a
//
//  Created by Wonji Ha on 2023/08/14.
//

/// 성적 관리 프로그램 (콘솔) 메인입니다.

import Foundation

var run: Bool = true
var myCreditManager = Functions()

while run {
    myCreditManager.loadStudents()
    print(Msg.Input.menuMsg)
    let input = readLine()!
    
    switch input {
    case "1":
        myCreditManager.createStudent()
    case"2":
        myCreditManager.deleteStudent()
    case"3":
        myCreditManager.updateGrade()
    case"4":
        myCreditManager.deleteGrade()
    case"5":
        myCreditManager.readGrade()
    case"X":
        myCreditManager.exit()
    default:
        print(Msg.Input.menuError)
    }
}
