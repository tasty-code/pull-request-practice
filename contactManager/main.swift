import Foundation

struct Contact : Hashable {
    let name : String
    let age : String
    let phoneNumber : String
    
    var description: String {
          "- \(self.name) / \(self.age) / \(self.phoneNumber)"
       }
}

enum ErrorType{
    case name
    case age
    case phoneNumber
}

enum GuideText {
   static let menu = "1) 연락처 추가 2) 연락처 목록보기 3) 연락처 검색 x) 종료"
   static let selectMenu = "메뉴를 선택해주세요 : "
}

enum MenuType: String {
    case addContact = "1"
    case viewContactList = "2"
    case findContact  = "3"
    case exit = "x"
}

struct Validation {
    static func validateInputBySlash(input: String) -> Bool {
        guard (input.filter{ $0 == "/" }.count == 2) else {
            return false
        }
        return true
    }

    static func validateInputByHyphenNum(input: String) -> Bool {
        guard (input.filter { $0 == "-" }.count == 2) else {
            return false
        }
        return true
    }
}

func errorTextOutput(with type: ErrorType){
    let errorText: String
    switch type {
    case .name: errorText = "이름"
    case .age: errorText = "나이"
    case .phoneNumber: errorText = "연락처"
    }
    print("입력한 \(errorText)정보가 잘못되었습니다. 입력 형식을 확인해주세요.")
}

var contacts : Set<Contact> = []

var isMenuInputError: Bool = false
let regex = "^[A-Za-z\\s]+$"

while !isMenuInputError {
    print(GuideText.menu)
    print(GuideText.selectMenu,terminator: "")
    guard let input = readLine(), let menu = MenuType(rawValue: input) else{
        print("선택이 잘못되었습니다. 확인 후 다시 입력해주세요.\n")
        continue
    }
    switch menu{
    case .addContact:
        addContact()
    case .viewContactList:
        for contact in contacts.sorted(by: {$0.name < $1.name}) {
            print(contact.description)
        }
        print("")
        continue
    case .findContact:
        print("연락처에서 찾을 이름을 입력해주세요 : ", terminator: "")
        guard let inputValue = readLine() else {
            continue
        }
        findContact(inputName: inputValue)
        continue
    case .exit:
        isMenuInputError = true
        print("\n[프로그램 종료]")
    }
}
