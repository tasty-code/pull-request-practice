//
//  StudentViewModel.swift
//  Git_ Exercise
//
//  Created by 송선화 on 2022/12/19.
//

import Foundation
import RealmSwift

let realm = try! Realm()

func findStudent(name: String) -> Student? {
    let data = realm.objects(Student.self).filter(NSPredicate(format: "name == %@", name)).first
    return data
}

func findSubject(name: String, subject: String) -> Grade? {
    guard let student = findStudent(name: name) else { return Grade() }
    let grade = student.grade.filter(NSPredicate(format: "subject == %@", subject)).first
    return grade
}

// 학생 추가
func addStudent(name: String) {
    if findStudent(name: name) == nil {
        do {
            try realm.write({
                realm.add(Student(name: name))
                print("\(name)학생을 추가했습니다.")
            })
        } catch {
            print("Error: realm 학생 추가 에러 발생")
        }
    } else {
        // 이미 동일한 이름의 학생 존재하는 경우, 학생추가 불가
        print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    }
}

// 학생 삭제
func deleteStudent(name: String) {
    // 학생이 없는 경우, 삭제 불가
    guard let student = findStudent(name: name) else {
        print("\(name)학생을 찾지 못했습니다.")
        return
    }
    
    do {
        try realm.write({
            realm.delete(student)
            print("\(name)학생을 삭제하였습니다.")
        })
    } catch {
        print("Error: realm 학생 삭제 에러 발생")
    }
}

// 학생 성적 추가/변경
func addStudentGrade(name: String, subject: String, score: String) {
    
    // 학생이 없을 경우, 성적 추가/변경 불가
    guard let student = findStudent(name: name) else {
        print("\(name)학생을 찾지 못했습니다.")
        return
    }
    
    guard let newScore = Score(rawValue: score) else { return }
    
    // 과목이 기존에 없었다면 nil
    guard let grade = findSubject(name: name, subject: subject) else {
        // 학생 과목, 성적 추가
        do {
            try realm.write({
                let newGrade = Grade(subject: subject, score: newScore)
                student.grade.append(newGrade)
                print("\(name)학생의 \(subject)과목이 \(score)로 추가(변경)되었습니다.")
            })
        } catch {
            print("Error: realm 성적 추가 에러 발생")
        }
        return
    }
    
    // 성적 변경
    do {
        try realm.write({
            grade.score = newScore
            print("\(name)학생의 \(subject)과목이 \(score)로 추가(변경)되었습니다.")
        })
    } catch {
        print("Error: realm 성적 변경 에러 발생")
    }
}

// 성적 삭제
func deleteStudentGrade(name: String, subject: String) {
    
    // 학생 이름이 없을 경우, 성적 삭제 불가
    guard findStudent(name: name) != nil else {
        print("\(name)학생을 찾지 못했습니다.")
        return
    }
    
    // 학생 이름은 있지만, 해당 학생 과목이 없는 경우
    guard let grade = findSubject(name: name, subject: subject) else {
        print("\(name)학생의 \(subject)과목을 찾지 못했습니다.")
        return
    }
    
    // 성적 삭제
    do {
        try realm.write({
            realm.delete(grade)
            print("\(name)학생의 \(subject)과목의 성적이 삭제되었습니다.")
        })
    } catch {
        print("Error: realm 성적 삭제 에러 발생")
    }
}

// 평점보기
func calculateGrade(name: String) {
    
    // 학생 이름이 없을 경우, 평점 보기 불가
    guard let student = findStudent(name: name) else {
        print("\(name)학생을 찾지 못했습니다.")
        return
    }
    
    let grade = student.grade
    
    if grade.isEmpty {
        print("\(name)은 등록된 성적 및 평점이 없습니다.")
    } else {
        var sum = 0.0
        
        grade.forEach { grade in
            sum += grade.score.numScore
            print("\(grade.subject): \(grade.score.rawValue)")
        }
        
        let totalSum = sum / Double(grade.count)
        // 평점 소수점 2자리까지 (소수점 3자리에서 반올림)
        print("평점 : \(round(totalSum*100)/100)")
    }
}


