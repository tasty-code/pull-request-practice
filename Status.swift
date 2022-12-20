//
//  Status.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

typealias ParsedInput = [Codable]

/// status 정보
enum Status: String, Codable {
    case start = "0"
    case addStudent = "1"
    case deleteStudent = "2"
    case addScore = "3"
    case deleteScore = "4"
    case showScoreAverage = "5"
    case exit = "X"
}

//MARK: - Info Message

extension Status {
    var infoMessage: String {
        switch self {
        case .start:
            return Info.start
        case .addStudent:
            return Info.Student.forAdd
        case .deleteStudent:
            return Info.Student.forDelete
        case .addScore:
            return Info.Score.forAdd
        case .deleteScore:
            return Info.Score.forDelete
        case .showScoreAverage:
            return Info.Score.forAverage
        default:
            return ""
        }
    }
}

//MARK: - Result Message

extension Status {
    func resMessage(input: ParsedInput) -> String? {
        switch self {
        case .addStudent:
            if let name = input[0] as? String {
                return Info.Student.added(name: name)
            }
        case .deleteStudent:
            if let name = input[0] as? String {
                return Info.Student.deleted(name: name)
            }
        case .addScore:
            if let name = input[0] as? String,
               let course = input[1] as? String,
               let score = input[2] as? Score {
                return Info.Score.added(name: name, course: course, score: score.description)
            }
        case .deleteScore:
            if let name = input[0] as? String,
               let course = input[1] as? String {
                return Info.Score.deleted(name: name, course: course)
            }
        default:
            return nil
        }
        return Info.Warning.failedToLoadReaction
    }
}

//MARK: - Status - parse method

extension Status {
    /// status에 따라 사용자 입력 parse
    func parse(input: String) -> ParsedInput? {
        let splited = input.components(separatedBy: " ")
        switch (self, splited.count) {
        case (.start, 1):
            guard let status = Status(rawValue: splited[0]) else {
                return nil
            }
            return [status]
        case (.addStudent, 1), (.deleteStudent, 1), (.showScoreAverage, 1):
            guard IOManager.checkValidity(of: splited[0]) else {
                return nil
            }
            return splited
        case (.addScore, 3):
            guard IOManager.checkValidity(of: splited[0]),
                  IOManager.checkValidity(of: splited[1]),
                  let score = Score(score: splited[2]) else {
                return nil
            }
            var res = [Codable]()
            res.append(contentsOf: splited)
            res[2] = score
            return res
        case (.deleteScore, 2):
            guard IOManager.checkValidity(of: splited[0]),
                  IOManager.checkValidity(of: splited[1]) else {
                return nil
            }
            return splited
        default:
            return nil
        }
    }
}
