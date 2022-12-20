//
//  ReportCard.swift
//  GradeManagement
//
//  Created by 박재우 on 2022/12/07.
//

import Foundation

func reportCard() {
    print(Questions.reportCard.rawValue)
    guard let student = readLine() else { return }
    guard let _ = student.range(of: Pattern.input.rawValue, options: .regularExpression),
          student.isEmpty == false else {
        print(Errors.input.rawValue)
        return
    }
    let isContain = manager.contains { $0.key == student }
    guard isContain else {
        print("\(student)\(Errors.searchStudent.rawValue)")
        return
    }
    guard let reports = manager[student] else {return}
    var average = 0.0
    for report in reports {
        print("\(report.subject): \(report.grade)")
        switch Grade(rawValue: report.grade) {
        case .APlus:
            average += Score.APlus.rawValue
        case .AZero:
            average += Score.AZero.rawValue
        case .BPlus:
            average += Score.BPlus.rawValue
        case .BZero:
            average += Score.BZero.rawValue
        case .CPlus:
            average += Score.CPlus.rawValue
        case .CZero:
            average += Score.CZero.rawValue
        case .DPlus:
            average += Score.DPlus.rawValue
        case .DZero:
            average += Score.DZero.rawValue
        default:
            average += 0.0
        }
    }
    average /= Double(reports.count)
    print("평점 : \(average)")
}
