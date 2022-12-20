import Foundation

let gradeDict: [String:Float] =
[
    "A+":4.5,
    "A0":4.0,
    "B+":3.5,
    "B0":3.0,
    "C+":2.5,
    "C0":2.0,
    "D+":1.5,
    "D0":1.0,
    "F":0.0
]

struct Course {
    var name: String
    var grade: String
}

struct Student {
    var name: String
    var courses: [String:Course] = [:]
}


class DataBase {
    private var students: [String:Student] = [:]
    
    func checkExist(name: String) -> Bool {
        return students[name] != nil
    }
    
    func addStudent(name:String) {
        if !checkExist(name: name) {
            students[name] = Student(name:name)
        }
    }
    
    func deleteStudent(name: String) {
        students[name] = nil
    }
    
    func addCourse(name: String, course: Course) {
        students[name]?.courses[course.name] = course
    }
    
    func deleteCourse(name: String, courseName: String) {
        students[name]?.courses[courseName] = nil
    }
    
    func checkGrade(name: String) -> String {
        var result = ""
        var score:Float = 0.0
        let targetCourses = students[name]!.courses
        for(_, course) in targetCourses {
            result.append("\(course.name): \(course.grade)\n")
            score += gradeDict[course.grade] ?? 0.0
        }
        score /= Float(targetCourses.count)
        result.append(String(format:"평점 : %.2f", score))
        return result
    }
    
    
}

//git
