//
//  ReadLine.swift
//  MyCreditManager_yj7472kr1230
//
//  Created by 송선화 on 2022/12/07.
//

import Foundation

// 모든 입력은 숫자/영문만 받아야 함.
// 예외) 성적 추가시, + 가능


// 영어 소문자, 대문자만 허용 (공백 허용X) (이름에 숫자가 들어가지 않으니, 숫자 제외)
func readLineForName() -> String? {
    let input = readLine()
    let regex = "^[a-zA-Z]*$"
    
    guard let input = input else { return nil }
    
    // 정규식에 어긋나거나, 빈 문자열인 경우
    if input.range(of: regex, options: .regularExpression) == nil || input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return nil
    } else {
        return input
    }
}

// 영어소/대숫_영어소/대숫_영어대+0 (과목명에는 + 제외)
// 학생이름_과목_성적 세 가지 요소 중 하나라도 없으면 에러
func readLineForGradeAdd() -> [String]? {
    let input = readLine()
    let regex = "^[a-zA-Z]+ [a-zA-Z0-9]+ ([ABCD][+0]|[F])$"
    
    guard let input = input else { return nil }
    
    // 정규식에 어긋나거나, 빈 문자열인 경우
    if input.range(of: regex, options: .regularExpression) == nil || input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return nil
    } else {
        return input.components(separatedBy: " ")
        // ["학생이름", "과목", "점수"]
    }
}

// 영어소/대_영어소/대숫
func readLineForGradeDelete() -> [String]? {
    let input = readLine()
    let regex = "^[a-zA-Z]+ [a-zA-Z0-9]+$"
    
    guard let input = input else { return nil }
    
    // 정규식에 어긋나거나, 빈 문자열인 경우
    if input.range(of: regex, options: .regularExpression) == nil || input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return nil
    } else {
        return input.components(separatedBy: " ")
        // ["학생이름", "과목"]
    }
}
