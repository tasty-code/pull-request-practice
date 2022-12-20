//
//  input data.swift
//  MyCreditManager_cdenen20
//
//  Created by Junely on 2022/12/07.
//

import Foundation

//MARK: - readLine()값 저장

///**'메뉴선택'용 입력값**을 저장하는 변수
///- main의 repeat-while문의 반복조건
///- `X`를 입력하면 반복문 종료
var inputMenu = String()

///**'기능실행'용 입력값(들)**을 저장하는 변수
///- main의 switch-case문에서 호출
///- 중복·가장자리 공백은 자동으로 처리, 유효한 단어 수에 따라 변수에 저장
var inputData = String()
var (name, subject, grade) = (String(), String(), String())
func getInputs(_ s: String = (readLine() ?? "")) {
    let input = s.components(separatedBy: .whitespaces).compactMap { try? checkInput(str: $0).get() }
    switch input.count {
        case 1: (name, subject, grade) = (input[0], "", "")
        case 2: (name, subject, grade) = (input[0], input[1], "")
        case 3: (name, subject, grade) = (input[0], input[1], input[2])
        default: print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
}


//MARK: - 허용된 입력값인지 검사

///**입력값 에러 종류** 목록
///- __notMenu__: `inputMenu`에 선택지 6종 외의 값이 들어올 경우
///- __notAlphanumeric__: `inputMenu` 또는 `inputData`에 영문·숫자가 아닌 자모가 포함된 경우
enum InputError: Error {
    case notMenu(text: String = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    case notAlphanumeric(text: String = "입력이 잘못되었습니다. 다시 확인해주세요.")
}

///**입력값 에러 판별** 함수
///- `checkInput(str:)`: **기능실행** 단계에서 활용
///- `checkInput(chr:)`: **기능선택** 단계에서 활용
func checkInput(str: String) -> Result<String?, InputError> {
    var isValid = Bool()
    for chr in str {
        isValid = chr.isCased || chr.isNumber || chr.isWhitespace || chr == "+"
    }
    guard isValid else { return .failure(InputError.notAlphanumeric()) }
    return .success(isValid ? str : nil)
}
///**입력값 에러 판별** 함수
///- `checkInput(str:)`: **기능실행** 단계에서 활용
///- `checkInput(chr:)`: **기능선택** 단계에서 활용
func checkInput(chr: String) -> Result<String, InputError> {
    guard chr.count == 1 && ["1", "2", "3", "4", "5", "X"].contains(chr) else { return .failure(InputError.notMenu()) }
    return .success(chr)
}


///**입력값 에러 처리** 함수 - 기능 선택 시
///+ 에러가 아니면 true, 에러에 해당하면 false를 반환
///+ 용도에 따라(guard문 조건 or 문구출력) 다용도로 사용
func getInput(_ checkedResult: Result<String, InputError>) -> Bool {
    switch checkedResult {
        case .success: return true //return try! checkedResult.get()
        case .failure(let error): print("\(error)".components(separatedBy: "\"")[1]); return false
    }
}
///**입력값 에러 처리** 함수 - 기능 실행 시
///+ 에러가 아니면 true, 에러에 해당하면 false를 반환
///+ 용도에 따라(guard문 조건 or 문구출력) 다용도로 사용
func getInput(_ checkedResult: Result<String?, InputError>) -> Bool {
    switch checkedResult {
        case .success: return true
        case .failure(let error): print("\(error)".components(separatedBy: "\"")[1]); return false
    }
}
