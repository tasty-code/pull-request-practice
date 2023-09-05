//
//  MyCreditManager.swift
//  MyCreditManager_2_kbs96117
//
//  Created by BOMBSGIE on 2023/08/17.
//

import Foundation

final class MyCreditManager {

    private var reportCards: [ReportCard] = []
    
    private let inputError: String = "입력이 잘못되었습니다. 다시 확인해주세요."
    private var documentDirectory: URL { FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! }
    
    private var reportCardsFileURL: URL { documentDirectory.appendingPathComponent("reportCards.json") }
    
    init() {
        loadReportCards(filePath: reportCardsFileURL)
    }
    
    func startMainMenu() {
        print("원하는 기능을 입력하세요.")
        print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
        guard let input = readLine() else {return}
        
        switch input {
        case "1": addStudent()
        case "2": deleteStudent()
        case "3": updateReport()
        case "4": deleteReport()
        case "5": showingReport()
        case "X":
            saveReportCards(reportCards: reportCards, filePath: reportCardsFileURL)
            print("프로그램을 종료합니다...")
            break
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            startMainMenu()
        }
       
        
    }
    
    
    
    private func addStudent(){
        print("추가할 학생의 이름을 입력해주세요.")
        
        guard let name = readLine(), validateInput(input: name) else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        
        if checkDuplicateName(studentName: name) {
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            reportCards.append(ReportCard(sudentName: name, reports: [:]))
            print("\(name) 학생을 추가했습니다.")
        }
        startMainMenu()
    }
    
    
    private func deleteStudent() {
        print("삭제할 학생의 이름을 입력해주세요.")
        
        guard let name = readLine(), validateInput(input: name) else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        
        if checkDuplicateName(studentName: name) {
            reportCards.removeAll {$0.sudentName == name}
            print("\(name) 학생을 삭제하였습니다.")
        } else {
            printStudentNotFount(name: name)
        }
        startMainMenu()
    }
    
    
    private func updateReport() {
        print(
        """
        성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
        입력예) Mickey Swift A+
        만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
        """)
        guard let input = readLine() else { return }
        let inputs: [String] = input.components(separatedBy: " ")
        
        guard inputs.count == 3  else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        
        let name: String = inputs[0]
        let subject: String = inputs[1]
        
        guard let grade = Grade(rawValue: inputs[2]), validateInput(input: name) && validateInput(input: subject) else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        
        guard checkDuplicateName(studentName: name) else {
            printStudentNotFount(name: name)
            startMainMenu()
            return
        }
        
        if let studentIndex: Int = reportCards.firstIndex(where: {$0.sudentName == name}) {
            reportCards[studentIndex].reports[subject] = grade
            print("\(name) 학생의 \(subject) 과목이 \(grade.rawValue)로 추가(변경) 되었습니다.")
        }
        
        startMainMenu()
    }
    
    private func deleteReport() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        guard let input = readLine() else { return }
        let inputs: [String] = input.components(separatedBy: " ")
        
        guard inputs.count == 2 && validateInput(input: inputs[0]) && validateInput(input: inputs[1]) else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        
        let name = inputs[0]
        let subject = inputs[1]
        
        
        guard let studentIndex: Int = reportCards.firstIndex(where: {$0.sudentName == name}) else {
            printStudentNotFount(name: name)
            startMainMenu()
            return
        }
        
        if let _ = reportCards[studentIndex].reports[subject] {
            reportCards[studentIndex].reports.removeValue(forKey: subject)
            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
            
        } else {
            print("\(name) 학생의 \(subject) 과목의 성적이 존재하지 않습니다.")
        }
        
        startMainMenu()
    }
    
    private func showingReport() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        guard let name = readLine(), validateInput(input: name) else {
            print("\(inputError)")
            startMainMenu()
            return
        }
        

        guard let studentIndex: Int = reportCards.firstIndex(where: {$0.sudentName == name}) else {
            printStudentNotFount(name: name)
            startMainMenu()
            return
        }
        
        if !reportCards[studentIndex].reports.isEmpty {
            let report = reportCards[studentIndex].reports
            let totalScore: Double = report.map {$0.value.score}.reduce(0,+)
            let averageScore: String = String(format: "%.2f", totalScore / Double(report.count))
            var roundedAverage: String {
                averageScore.hasSuffix("0") ? String(averageScore.dropLast()) : averageScore
            }
            
            report.forEach { subject, grade in
                print("\(subject): \(grade.rawValue)")
            }
            print("평점: \(roundedAverage)")
            
            
        } else {
            print("\(name) 학생의 성적이 존재하지 않습니다.")
        }
        startMainMenu()
    }
    
    
}


//MARK: - Extension MyCreditManager
extension MyCreditManager {
    
    private func checkDuplicateName(studentName: String) -> Bool {
        return reportCards.contains { $0.sudentName == studentName}
    }
    
    
    private func validateInput(input: String) -> Bool{
        let vaildCharcterSet = CharacterSet.alphanumerics
        return input.rangeOfCharacter(from: vaildCharcterSet) != nil && !input.contains(" ")
    }
    
    
    private func printStudentNotFount(name: String) {
        print("\(name) 학생을 찾지 못했습니다.")
    }
    
    //MARK: - File Persistence로 배열 저장 및 저장된 데이터 불러오는 함수
    private func saveReportCards(reportCards: [ReportCard], filePath: URL) {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(reportCards)
            try jsonData.write(to: filePath)
        } catch {
          print("File Persistence 저장 안됨 \(error)")
        }
    }
    
    private func loadReportCards(filePath: URL) {
        do {
            let jsonData = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let loadedReportCards = try decoder.decode([ReportCard].self, from: jsonData)
            reportCards = loadedReportCards
        } catch {
            reportCards = []
        }
    }

    
}


