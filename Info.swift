//
//  Info.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

enum Info {
    static let start = """
        원하는 기능을 입력해주세요.
          1: 학생 추가, 2: 학생 삭제, 3: 성적 추가(변경), 4: 성적 삭제, 5: 평점 보기, X: 종료
        """
    enum Student {
        static let forAdd = "추가할 학생의 이름을 입력해주세요."
        static func added(name: String) -> String {
            return "\(name) 학생을 추가했습니다."
        }
        static let forDelete = "삭제할 학생의 이름을 입력해주세요."
        static func deleted(name: String) -> String {
            return "\(name) 학생을 삭제했습니다."
        }
    }
    enum Score {
        static let forAdd = """
            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
              입력 예) Mickey Swift A+
              학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
            """
        static func added(name:String, course: String, score: String) -> String {
                return "\(name) 학생의 \(course) 과목이 \(score)로 추가(변경)되었습니다."
        }
        static let forDelete = """
            성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
              입력 예) Mickey Swift
            """
        static func deleted(name:String, course:String) -> String {
            return "\(name) 학생의 \(course) 과목의 성적이 삭제되었습니다."
        }
        static let forAverage = "평점을 알고 싶은 학생의 이름을 입력해주세요."
    }
    enum Data {
        static func saved(names: [String]) -> String {
            return names.isEmpty ? "저장할 학생 정보가 없습니다."
                : """
                학생과 성적 정보를 성공적으로 저장했습니다.
                저장된 학생: \(names.joined(separator: ", "))
                """
        }
        static func loaded(names: [String]) -> String {
            return """
            학생과 성적 정보를 성공적으로 불러왔습니다.
            불러온 학생: \(names.joined(separator: ", "))
            """
        }
    }
    
    enum Warning {
        static let failedToLoadData = "기존의 Data를 불러오는 데 실패했습니다."
        static let failedToLoadReaction = "실행 결과 안내 메세지를 불러오는 데 실패했습니다."
    }
}
