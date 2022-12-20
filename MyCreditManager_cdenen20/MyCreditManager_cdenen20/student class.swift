//
//  student class.swift
//  MyCreditManager_cdenen20
//
//  Created by Junely on 2022/12/05.
//

import Foundation

///학생객체를 생성하고 관리하는 클래스
///- `students`: 이름(key)에 대응하는 학생객체(value)를 저장
///- `grades`: 과목(key)에 대응하는 성적(value)을 저장
class Student: Codable {

    static var students = [String: Student]()
    let name: String
    var grades = [String: String]()
    
    ///평점 계산
    var overallScore: Double {
        let gradeList = ["F", "D0", "D+", "C0", "C+", "B0", "B+", "A0", "A+"]
        let scoreList = [0, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5]
        return grades.values.map { scoreList[gradeList.firstIndex(of: $0) ?? 0] }.reduce(0, +) / Double(grades.count)
    }
    
    ///학생 추가
    init?(name: String) {
        if Student.students.keys.contains(name) {
            print("\(name)은(는) 이미 존재하는 학생입니다. 추가하지 않습니다.")
            return nil
        }
        self.name = name
        Self.students.updateValue(self, forKey: name)
        print("\(name) 학생을 추가했습니다.")
    }
    
    ///학생 삭제
    deinit {
        print("\(name) 학생을 삭제하였습니다.")
    }
    
}
