//
//  main.swift
//  MyCreditManager_2r0ztar
//
//  Created by 이상윤 on 2022/12/06.
//

/*
 <Reference>
 1. 파일 입출력: https://developer.apple.com/documentation/foundation/file_system
 2. FileManager: https://leeari95.tistory.com/32
 3. String to Dictionary: https://developer.apple.com/documentation/foundation/nsstring/1407697-propertylistfromstringsfileforma
 
 <To-Do>
 1. 여러 학생의 구조체 만드는 방법
 2. 한 txt 파일에 이름과 강의 정보를 다 담고, 불러올 수 있는 방법
 */


// Foundation: 필수 데이터 유형, 컬렉션 및 운영 체제 서비스에 접근하여 앱의 기본 계층을 정의하는 데 사용
import Foundation

// 각 학생의 정보를 담고 있어야 하기에 구조체 생성
struct Student {
    var studentName: String = "" // 학생 이름 저장
    var subjectGrade: [String:String] = [:] // 학생의 강의:성적 저장
    var averageGrade: Float = 0 // 학생 평점 저장
    
    // mutating: 구조체 메소드에서 프로퍼티를 수정하기 위해 사용되는 키워드
    mutating func Calculate() -> Float{
        var temp: Array<String> = [] // subjectGrade 에서 성적만 가져올 임시 배열
        var point: Float = 0 // gradePoint를 통해 치환된 점수를 저장할 변수
        // subjectGrade에서 값들을 뽑아 임시 배열에 저장.
        // append 꼭 사용하기. index로 접근하면 out of range 오류 발생
        for value in subjectGrade.values{
            temp.append(value)
        }
        // 변수에 치환된 값들을 누적 저장
        for grade in temp {
            point += gradePoint[grade]!
        }
        // averageGrade에 point를 강의 수로 나눈 값을 저장. subjectGrade.count로는 오류가 발생하여 같은 타입인 Float으로 변환
        averageGrade = point / Float(subjectGrade.count)
        return averageGrade // 평점값 반환
    }
}

// 받은 성적을 점수로 치환하기 위해 값을 매칭하여 Dictionary로 먼저 설정해 놓음
let gradePoint: [String:Float] = ["A+":4.5, "A0":4, "B+":3.5, "B0":3, "C+":2.5, "C0":2, "D+":1.5, "D0":1, "F":0]

// 정규식을 통해 모든 입력은 숫자 또는 영문(대소문자)으로 받을 수 있게 처리. 하지만 메뉴선택은 switch로 제어하기에 적용하지 않았음
let regex1 = "[a-zA-Z0-9]"

var menuNumber: String = "" // 사용자에게 입력 받을 메뉴를 저장할 변수
var inputStudent: Student = Student() // 사용자에게 입력 받은 정보를 저장할 구조체

let fileManager: FileManager = FileManager.default // FileManager 인스턴스 생성
let docPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0] // 문서 경로
let directoryPath: URL = docPath.appending(path: "File Manager") // 파일을 저장할 디렉토리 경로 반환
let namePath: URL = directoryPath.appending(path: "save.txt") // 디렉토리에 만들 학생 이름 파일
let subjectGradePath: URL = directoryPath.appending(path: "sgsave.txt") // 디렉토리에 만들 강의정보 파일

// fileManager로 디렉토리 생성
do {
    // 디렉토리 경로에 디렉토리 생성(폴더)
    try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false)
} catch let e {
    // 에러메세지 출력
    print(e.localizedDescription)
}

// 만들었던 파일 불러와서 읽기 - 이름 파일
do {
    // 저장한 경로를 통해 데이터를 불러옴
    let dataFromPath: Data = try Data(contentsOf: namePath)
    // String 타입 text에 utf8 인코딩으로 데이터를 집어넣고 없으면 문서 없음.
    let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서 없음"
    // 학생 구조체에 파일에서 불러온 이름 저장
    inputStudent.studentName = text
} catch let e {
    print(e.localizedDescription)
}

// 만들었던 파일 불러와서 읽기 - 강의 정보 파일.
do {
    // 저장한 경로를 통해 데이터를 불러옴
    let dataFromPath: Data = try Data(contentsOf: subjectGradePath)
    // 인코딩하여 String 타입으로 넣는데, trimming으로 앞뒤 []를 지운다
    let text: String = String(data: dataFromPath, encoding: .utf8)?.trimmingCharacters(in: ["[", "]"]) ?? "문서 없음"
    // trimming한 text를 Dictionary에 넣기 위한 사전 작업. 키값 쌍을 콜론 대신 등호로 바꾸고, 각 쌍의 구분은 콤마가 아닌 세미콜론으로 한다.
    var tmpText: String = text.replacingOccurrences(of: ":", with: "=")
    tmpText = tmpText.replacingOccurrences(of: ",", with: ";")
    tmpText = tmpText + ";"
    // 학생 구조체에 파일에서 불러온 강의 정보 Dictionary를 저장
    inputStudent.subjectGrade = tmpText.propertyListFromStringsFileFormat()
} catch let e {
    print(e.localizedDescription)
}

// 메인 화면은 종료 전까지 출력되어야 하기에 while 반복문 사용
while(menuNumber != "X"){
    // 메인 화면에서의 메뉴 구성
    print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    // 옵셔널 바인딩으로 입력한 메뉴가 nil이 아니라면 임시 메뉴변수에 대입
    if let temNum = readLine(){
        menuNumber = temNum
        // 각 메뉴 상황을 switch case로 제어
        switch menuNumber{
        case "1": // 학생추가
            print("추가할 학생의 이름을 입력해주세요")
            // 학생 이름 입력시 nil이 아니라면 임시 이름변수에 대입
            if let temName = readLine() {
                // 영문이나 숫자가 아니라면 예외처리
                if(temName.range(of: regex1, options: .regularExpression) == nil){
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                // 예외처리 대상이 아닐 시 기존의 학생 구조체의 이름과 비교
                else if(temName != inputStudent.studentName){
                    inputStudent.studentName = temName // 기존의 이름에 없다면 추가
                    print("\(inputStudent.studentName) 학생을 추가했습니다.")
                }
                else { // 기존의 이름과 같다면 추가하지 않음
                    print("\(inputStudent.studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
                }
            }
        case "2": // 학생삭제
            print("삭제할 학생의 이름을 입력해주세요")
            // 학생 이름 입력 시 nil이 아니라면 임시 이름변수에 대입
            if let temName = readLine() {
                // 영문이나 숫자가 아니라면 예외처리
                if(temName.range(of: regex1, options: .regularExpression) == nil){
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                // 예외처리 대상이 아닐 시 기존의 학생 구조체의 이름과 비교
                else if(temName != inputStudent.studentName){ // 기존의 이름에 없다면 오류 출력
                    print("\(temName) 학생을 찾지 못했습니다.")
                }
                // 이미 입력되어 있는 학생이라면, 구조체 내 정보를 다 초기화하고 문구 출력
                else {
                    inputStudent.studentName = ""
                    inputStudent.subjectGrade.removeAll()
                    inputStudent.averageGrade = 0
                    print("\(temName) 학생을 삭제하였습니다.")
                }
            }
        case "3": // 성적추가(변경)
            print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A0, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
            if let temString = readLine(){
                // 입력값이 영문이나 숫자가 아니고 이름+과목, 과목+성적 등 전체 항목을 적지 않았을 때 예외처리
                if(temString.range(of: regex1, options: .regularExpression) == nil || temString.components(separatedBy: [" "]).count != 3){
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                // 정규식, 전체 항목 오류가 없고, 이름을 잘 입력했다면 추가(변경) 진행
                else if(temString.contains("\(inputStudent.studentName)")) {
                    // 성적을 잘 입력했는지 ContainC를 통해 확인
                    if(ContainC(temString: temString)){
                        // 임시 배열에 입력값을 공백으로 구분하여 저장(구조체에 각각 저장하기 위해)
                        let temArr: Array = temString.components(separatedBy: [" "])
                        // 학생 구조체 성적 딕셔너리에 키를 두 번째 값(과목 이름)으로 하는 세 번째 값(성적)을 밸류로 저장
                        inputStudent.subjectGrade.updateValue(temArr[2], forKey: temArr[1])
                        // 결과를 출력하는데 동일 성적을 가진 과목이 있을 것이기에 임시 배열의 과목값으로 과목 이름을 표기하고 해당 과목에 제대로 값이 저장되었는지 확인하기 위해 성적은 학생 구조체에서 값을 가져옴
                        print("\(inputStudent.studentName) 학생의 \(temArr[1]) 과목이 \(inputStudent.subjectGrade[temArr[1]]!)로 추가(변경)되었습니다.")
                    }
                    else {
                        print("성적을 잘못 입력하셨습니다.")
                    }
                }
                // 위 가정에서 성적이 ContainC에서 입력한 값에서 벗어날 시 예외처리
                else {
                    print("없는 학생의 성적을 추가할 수 없습니다.")
                }
            }
        case "4": // 성적삭제
            print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
            print("입력예) Mickey Swift")
            if let temString = readLine(){
                // 입력값이 영문이나 숫자가 아니고 띄어쓰기상 두 개의 입력값이 없으면 예외처리
                if(temString.range(of: regex1, options: .regularExpression) == nil || temString.components(separatedBy: [" "]).count != 2){
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                // 입력한 값에 저장된 학생의 이름이 있는지 확인
                else if(temString.contains("\(inputStudent.studentName)")){
                    // 이름이 있다면 임시 배열에 입력값을 저장
                    let temArr: Array = temString.components(separatedBy: [" "])
                    // 학생 구조체에서 입력한 과목이 없다면 예외처리
                    if(inputStudent.subjectGrade[temArr[1]] == nil){
                        print("입력한 과목의 저장된 성적이 없습니다.")
                    }
                    // 학생 이름이 있고, 입력한 과목에 대한 성적값이 있다면 해당 과목의 값을 nil 처리하여 제거
                    else {
                        inputStudent.subjectGrade[temArr[1]] = nil
                        print("\(inputStudent.studentName) 학생의 \(temArr[1]) 과목의 성적이 삭제되었습니다.")
                    }
                }
                // 학생의 이름이 없을 때 예외처리
                else {
                    let temArr: Array = temString.components(separatedBy: [" "])
                    print("\(temArr[0]) 학생을 찾지 못했습니다.")
                }
            }
        case "5": // 평점보기
            print("평점을 알고싶은 학생의 이름을 입력해주세요")
            if let temString = readLine(){
                // 영문이나 숫자가 아니라면 예외처리
                if(temString.range(of: regex1, options: .regularExpression) == nil){
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
                // 입력값에 학생 이름이 없으면 예외처리
                else if(temString != inputStudent.studentName){
                    print("\(temString) 학생을 찾지 못했습니다.")
                }
                // 학생 구조체에 등록된 성적이 없으면 예외처리
                else if(inputStudent.subjectGrade.count == 0){
                    print("표시할 성적이 없습니다.")
                }
                // 학생 이름이 있고, 등록된 성적이 있을 시 평점보기 진행
                else {
                    // Dictionary는 순서가 없어 키값 기준으로 정렬해서 보여주면 좋을 것 같음
                    let keySortedDict = inputStudent.subjectGrade.sorted(by: {$0.0 < $1.0})
                    // for in 문으로 정렬된 Dic에서 과목:성적을 출력
                    for (key, value) in keySortedDict{
                        print("\(key): \(value)")
                    }
                    // 소수점 2자리까지 표현하고자 String(format)을 사용, 학생 구조체의 Calculate 실행으로 평점 계산
                    print("평점 : ", String(format: "%.2f", inputStudent.Calculate()))
                }
            }
        case "X": // 종료
            // 위에서 만든 save.txt 파일에 학생 이름 저장
            if let data: Data = inputStudent.studentName.data(using: String.Encoding.utf8) {
                do{
                    try data.write(to: namePath)
                } catch let e {
                    print(e.localizedDescription)
                }
            }
            // 위에서 만든 sgsave.txt 파일에 과목 이름과 성적 저장
            if let data: Data = inputStudent.subjectGrade.description.data(using: String.Encoding.utf8) {
                do{
                    try data.write(to: subjectGradePath)
                } catch let e {
                    print(e.localizedDescription)
                }
            }
            print("프로그램을 종료합니다...")
        default:
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        }
    }
}

// case "3" 에서 성적 예외처리를 할 때 조건이 길어 따로 func로 빼두었음
func ContainC (temString: String) -> Bool {
    // 입력받은 값에 하기의 성적들이 포함되면 true, 포함되지 않으면 false 반환. 나중에 F에 대한 처리 개선 필요
    if(temString.contains("A+") || temString.contains("A0") || temString.contains("B+") || temString.contains("B0") || temString.contains("C+") || temString.contains("C0") || temString.contains("D+") || temString.contains("D0") || temString.contains("F")){
        return true
    }
    else{
        return false
    }
}
