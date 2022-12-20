//
//  SystemMenu.swift
//  MyCreditManager_jasonLee0223
//
//  Created by Jason on 2022/12/06.
//

import Foundation

protocol SystemMenu {
    func addToStudent()
    func deleteToStudent()
    func addOrChangeToGrade()
    func deleteGrade()
    func viewOfAverage()
    func exitMenu(input value: String?)
}

protocol DataManager {
    func receiveUserSingleInputValue() -> String
    func receiveUserThreeInputValues() -> [String]
    func featureOf(compare inputValue: String) throws -> String
    func featureOf(same name: String, compare value: String) -> Bool
    func featureTo(add nameValue: String?) -> DataTable?
    func delete()
    func change()
}

extension DataManager {
    func receiveUserSingleInputValue() -> String {
        guard let inputValue = readLine() else {
            return ""
        }
        return inputValue
    }
    
    func receiveUserThreeInputValues() -> [String] {
        guard let inputThreeValues = readLine()?.components(separatedBy: " ") else {
            return ["", "", ""]
        }
        return inputThreeValues
    }
    
    func featureOf(compare inputValue: String) throws -> String {
        guard inputValue != " " && inputValue != "" else {
            throw DataError.invalidUserInputSingle(Value: inputValue)
        }
        return inputValue
    }
    
    func featureOf(same name: String, compare userInput: String) -> Bool {
        guard name == userInput else {
            return false
        }
        PrintMessage().sameStudent(name)
        return true
    }
    
    func featureTo(add nameValue: String?) -> DataTable? {
        guard let receivedData = nameValue else {
            return nil
        }
        return DataTable(name: receivedData, subject: "", grade: .Unknown)
    }
    
    func delete() {
        // code
    }
    
    func change() {
        // code
    }
}
