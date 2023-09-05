//
//  String.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/15.
//

import Foundation

extension String {
    /// 대상 String 에 대해 GradeType 요소로 반환
    ///
    /// ```
    /// let input: String = "A0"
    /// input.convertStringToGrade() // GradeType.a
    ///
    /// let arr: [String] = ["A0", "B+", "D0"]
    /// arr.map {$0.convertStringToGrade()} // [GradeType.a, GradeType.bPlus, GradeType.d]
    /// ```
    ///
    /// - Important: 성적과 무관한 문자열에 대해서 사용하면 GradeType.f 라는 기본값으로 반환되니 주의할 것.
    func convertToGrade() -> GradeType {
        switch self {
        case "A+": return GradeType.aPlus
        case "A0": return GradeType.a
        case "B+": return GradeType.bPlus
        case "B0": return GradeType.b
        case "C+": return GradeType.cPlus
        case "C0": return GradeType.c
        case "D+": return GradeType.dPlus
        case "D0": return GradeType.d
        default: return GradeType.f
        }
    }
}
