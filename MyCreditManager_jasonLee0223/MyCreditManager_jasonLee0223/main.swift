//
//  main.swift
//  MyCreditManager_jasonLee0223
//
//  Created by Jason on 2022/12/06.
//

import Foundation

final class MyCreditManager {
    func menuStart() {
        let process = Process()
        let printMessage = PrintMessage()
        var exitValue:String = ""
        
        repeat {
            printMessage.initial()
            
            guard let inputValue = readLine() else {
                return
            }
            
            exitValue = inputValue
            switch ExecuteMenu(rawValue: inputValue) {
            case .addStudent:
                process.addToStudent()
                break
            case .deleteStudent:
                process.deleteToStudent()
                break
            case .addOrChangeToGrade:
                process.addOrChangeToGrade()
                break
            case .deleteGrade:
                process.deleteGrade()
                break
            case .averageView:
                break
            case .exitCommand:
                process.exitMenu(input: inputValue)
                break
                
            default:
                printMessage.defaultError()
            }
        } while exitValue != "X"
    }
}
MyCreditManager().menuStart()
