import Foundation

class Student: Codable {
    var name: String
    var grade: [String: String]!

    init(name: String) {
        self.name = name
        self.grade = [:]
    }
    
    func average() -> Double {
        var totalScore = 0.0
        let totalSubjects = Double(grade.count)

        for total in grade.values {
            switch total {
            case "A+":
                totalScore += 4.5
            case "A0":
                totalScore += 4.0
            case "B+":
                totalScore += 3.5
            case "B0":
                totalScore += 3.0
            case "C+":
                totalScore += 2.5
            case "C0":
                totalScore += 2.0
            case "D+":
                totalScore += 1.5
            case "D0":
                totalScore += 1.0
            case "F":
                totalScore += 0.0
            default:
                break
            }
        }
        let average = totalScore / totalSubjects
        let finalAverage = round(average * 100)/100
        return finalAverage
    }
}

// 메뉴의 기능 모음
class MenuFunction {
    static func menuSelect() -> String {
        let number = readLine()
        var userSelect = String()
        if let userInput = number {
            userSelect = userInput
        }
        return userSelect
    }

    static func addName() {
        let inputName = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let studentName = inputName {
            if studentName.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else if students[studentName] != nil {
                print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            } else {
                students[studentName] = Student(name: studentName)
                print("\(studentName) 학생을 추가했습니다.")
            }
        }
    }

    static func deleteStudent() {
        let inputName = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
        if let studentName = inputName, !studentName.isEmpty {
            if let student = students[studentName] {
                students.removeValue(forKey: studentName)
                print("\(student.name) 학생을 삭제하였습니다.")
            } else {
                print("\(studentName) 학생을 찾지 못했습니다.")
            }
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }

    static func addScore() {
        let userInput = readLine()
        var nameSubjectScore = Array<String>()
        if let studentInfo = userInput {
            nameSubjectScore = studentInfo.components(separatedBy: " ")

            if nameSubjectScore.count != 3 {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else if let student = students[nameSubjectScore[0]] {
                student.grade[nameSubjectScore[1]] = nameSubjectScore[2] 
                print("\(nameSubjectScore[0]) 학생의 \(nameSubjectScore[1]) 과목 성적이 추가(변경)되었습니다.")
            } else {
                print("\(nameSubjectScore[0]) 학생은 등록되지 않았습니다. 성적을 추가할 수 없습니다.")
            }
        }
    }

    static func deleteScore() {
        let userInput = readLine()
        if let studentInfo = userInput?.trimmingCharacters(in: .whitespacesAndNewlines) {
            let nameSubjectScore = studentInfo.components(separatedBy: " ")

            if nameSubjectScore.isEmpty || nameSubjectScore.count != 2 {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else if let student = students[nameSubjectScore[0]] {
                if student.grade[nameSubjectScore[1]] == nil {
                    print("\(nameSubjectScore[1]) 과목의 성적이 존재하지 않습니다.")
                }else {
                    student.grade.removeValue(forKey: nameSubjectScore[1])
                    print("\(nameSubjectScore[0]) 학생의 \(nameSubjectScore[1]) 과목의 성적이 삭제 되었습니다")
                }
            } else {
                print("\(nameSubjectScore[0]) 학생을 찾지 못했습니다.")
            }
        }
    }

    static func showAverage() {
        let userInput = readLine()
        if let name = userInput?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty {
            if let student = students[name] {
                if student.grade.isEmpty {
                    print("\(name) 학생의 성적이 없습니다.")
                } else {
                    for (subject, score) in student.grade {
                        print("\(subject): \(score)")
                    }
                    print("평점: \(student.average())")
                }
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        } else {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        }
    }
}

var students: [String: Student] = [:]

// students파일 저장 및 불러오기
func saveStudentsFile() {
    if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentURL.appendingPathComponent("students_data.plist")

        do {
            let data = try PropertyListEncoder().encode(students)
            try data.write(to: fileURL)
        } catch let error {
            print("저장 실패: \(error)")
        }
    }
}

func loadStudentsFile() {
    if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentURL.appendingPathComponent("students_data.plist")

        do {
            let data = try Data(contentsOf: fileURL)
            let loadedStudents = try PropertyListDecoder().decode([String: Student].self, from: data)
            students = loadedStudents
        } catch let error {
            print("불러오기 실패: \(error)")
        }
    }
}


func main() {
    loadStudentsFile() 

    menu: while true {
        print("""
        원하는 기능을 입력해 주세요
        1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료)
        """)
        let menuSelect = MenuFunction.menuSelect()
        switch menuSelect {
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            MenuFunction.addName()
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            MenuFunction.deleteStudent()
        case "3":
            print("""
            성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
            입력예) Mickey Swift A+
            만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
            """)
            MenuFunction.addScore()
        case "4":
            print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            MenuFunction.deleteScore()
        case "5":
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
            MenuFunction.showAverage()
        case "X":
            print("프로그램을 종료합니다…")
            saveStudentsFile() // 프로그램 종료 시 students 파일 저장
            break menu
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

main()
