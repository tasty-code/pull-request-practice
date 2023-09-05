//
//  CheckString.swift
//  MyCreditManager_2_01234a
//
//  Created by Wonji Ha on 2023/08/16.
//

import Foundation
/// 정규식 검사
extension String {
    func checkValue (value: String?) -> Bool {
        guard value != nil else { return false }
        let pattern = "^[0-9\\s,+,!@#$%^&*]*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: self)
    }
}
