//
//  Double.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/14.
//

import Foundation

extension Double {
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// 대상 Double 에 대해 최대 두 자리의 소수점 형식으로 하여 String 으로 반환
    ///
    /// ```
    /// let number: Double = 1.2345
    /// number.asStringWithTwoDecimals()
    /// ```
    ///
    /// - Returns: 최대 두 자리의 소수점 형식, String 타입 결과물 반환
    ///
    /// - Important: 올림, 내림, 반올림 등의 변경과는 연관이 없는 메서드임
    func asStringWithTwoDecimals() -> String {
        let number = NSNumber(value: self)
        return formatter.string(from: number) ?? ""
    }
}
