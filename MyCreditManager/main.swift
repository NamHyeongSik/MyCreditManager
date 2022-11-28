//
//  main.swift
//  MyCreditManager
//
//  Created by HYEONG SIK NAM on 2022/11/15.
//

import Foundation

struct Student {
    let name: String
    var score: [String: String]
    var average: Double {
        let n = score.count
        if n == 0 { return 0.0 }
        
        var sum = 0.0
        score.values.forEach {
            switch $0 {
            case "A+":
                sum += 4.5
            case "A":
                sum += 4.0
            case "B+":
                sum += 3.5
            case "B":
                sum += 3.0
            case "C+":
                sum += 2.5
            case "C":
                sum += 2.0
            case "D+":
                sum += 1.5
            case "D":
                sum += 1.0
            default:
                sum += 0.0
            }
        }
        return sum / Double(n)
    }
}

var list = [String: Student]()

func printDefault() {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}

func addStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    
    guard let name = readLine() else { return }
    
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    if list[name] == nil {
        list[name] = Student(name: name, score: [String : String]())
        print("\(name) 학생을 추가했습니다.")
    } else {
        print("\(name) 학생은 이미 존재하는 학생입니다. 추가하지 않습니다.")
    }
}

func removeStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    guard let name = readLine() else { return }
    
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    if list[name] != nil {
        list[name] = nil
        print("\(name) 학생을 삭제하였습니다.")
    } else {
        print("\(name) 학생을 찾지 못했습니다.")
    }
}

func addGrade() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    guard let cmd = readLine() else { return }
    
    if cmd.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    let arr = cmd.components(separatedBy: " ")
    if arr.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    let name = arr[0]
    let subject = arr[1]
    let grade = arr[2]
    guard var student = list[name] else {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    student.score[subject] = grade
    list[name] = student
    print("\(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경)되었습니다.")
}

func removeGrade() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    
    guard let cmd = readLine() else { return }
    
    if cmd.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    let arr = cmd.components(separatedBy: " ")
    if arr.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    let name = arr[0]
    let subject = arr[1]
    guard var student = list[name] else {
        print("\(name) 학생을 찾지 못했습니다.")
        return
    }
    
    student.score[subject] = nil
    list[name] = student
    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
}

func showAverage() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    guard let name = readLine() else { return }
    
    if name.isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    }
    
    guard let student = list[name] else {
        print("\(name) 학생을 찾지 못했습니다.")
        return
    }
    
    student.score.forEach { (subject, grade) in
        print("\(subject): \(grade)")
    }
    print(round(student.average * 100) / 100)
}

while true {
    printDefault()
    guard let cmd = readLine() else { break }
    
    switch cmd {
    case "1":
        addStudent()
    case "2":
        removeStudent()
    case "3":
        addGrade()
    case "4":
        removeGrade()
    case "5":
        showAverage()
    case "X":
        print("프로그램을 종료합니다...")
        break
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    if cmd == "X" {
        break
    }
}
