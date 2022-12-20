//
//  Process.swift
//  MyCreditManager_jasonLee0223
//
//  Created by Jason on 2022/12/06.
//

import Foundation

class Process: SystemMenu, DataManager {
    private var dataTableArray = [DataTable]()
    let printMessage = PrintMessage()
    
    func addToStudent() {
        printMessage.enterStudentName()
        let inputValue = receiveUserSingleInputValue()
        let correctValue = getInvalidInput(receivedValue: inputValue)
        if correctValue == nil {
            return
        }
        
        let studentName = dataTableArray.filter{ $0.name == inputValue }.map{ $0.name }.joined()
        if featureOf(same: studentName, compare: inputValue) == true {
            return
        }
        
        guard let sendOfData = featureTo(add: correctValue) else {
            return
        }
        dataTableArray.append(sendOfData)
        printMessage.addStudent(inputValue)
    }
    
    func deleteToStudent() {
        printMessage.wishToDeleteStudentName()
        let inputValue = receiveUserSingleInputValue()
        let correctValue = getInvalidInput(receivedValue: inputValue)
        if correctValue == nil {
            return
        }
        
        guard let filterElement = dataTableArray.filter({ $0.name == correctValue }).first else {
            printMessage.notCollectDeleteStudent(inputValue)
            return
        }
        
        guard let findIndex = dataTableArray.firstIndex(of: filterElement) else {
            return
        }
        dataTableArray.remove(at: findIndex)
        printMessage.deleteStudent(inputValue)
    }
    
    func addOrChangeToGrade() {
        printMessage.enterTheGradeAndSubject()
        
        let inputThreeValues = receiveUserThreeInputValues()
        let compareUserInput = inputThreeValues.map{$0 == "" || $0 == " "}
        var isPossibleContinue: Bool = false
        
        for index in 0..<inputThreeValues.count {
            if compareUserInput[index] == true {
                let errorElement = getInvalidInput(receivedValue: inputThreeValues[index])
                if errorElement == nil {
                    break
                }
                isPossibleContinue = false
            } else {
                let correctName = featureOfCompare(studentName: inputThreeValues[index])
                if correctName == nil {
                    break
                }
                isPossibleContinue = true
                break
            }
        }
        
        if isPossibleContinue == true {
            var tableArrayIndexCount = 0
            for index in 0..<inputThreeValues.count {
                if inputThreeValues[index] == "Swift" {
                    let changeSubjectValue = inputThreeValues[index]
                    dataTableArray[tableArrayIndexCount].subject = changeSubjectValue
                    tableArrayIndexCount += 1
                }
            }
            printMessage.collectThreeInputValue(inputThreeValues[0], inputThreeValues[1], inputThreeValues[2])
        }
    }
    
    func deleteGrade() {
        
    }
    
    func viewOfAverage() {
        
    }
    
    func exitMenu(input value: String?) {
        guard let inputValue = value else {
            return
        }
        if inputValue == "X" {
            printMessage.endProcess()
            exit(0)
        }
    }
    
    func featureOfCompare(studentName: String) -> String? {
        if studentName != dataTableArray.first?.name {
            printMessage.invalidInputNotice()
            return nil
        }
        return studentName
    }
}

//MARK: - Error Handling
extension Process {
    func getInvalidInput(receivedValue: String) -> String? {
        do {
            _ = try featureOf(compare: receivedValue)
        } catch DataError.invalidUserInputSingle(Value: receivedValue) {
            printMessage.invalidInputNotice()
            return nil
        } catch {
            fatalError("Wrong User Input")
        }
        return receivedValue
    }
}
