//
//  store data.swift
//  MyCreditManager_cdenen20
//
//  Created by Junely on 2022/12/08.
//

import Foundation

//MARK: - 학생객체를 백그라운드에 저장하는 방법

///이번 실행데이터 저장하기
func saveWholeData() {
    let path = "/Users/Junely/Desktop/새싹/tastycode_SeSAC_1st/MyCreditManager_cdenen20/MyCreditManager_cdenen20/Info.plist"
    let backupDictionary = NSMutableDictionary(contentsOfFile: path) ?? [:]
    let encoder = PropertyListEncoder()
    let encodedData = try! encoder.encode(Student.students)
    try! encodedData.write(to: .init(fileURLWithPath: path))
}

///지난 실행데이터 불러오기
func readWholeData() {
    let path = "/Users/Junely/Desktop/새싹/tastycode_SeSAC_1st/MyCreditManager_cdenen20/MyCreditManager_cdenen20/Info.plist"
    let backupDictionary = try! Data(contentsOf: URL(fileURLWithPath: path))
    let decoder = PropertyListDecoder()
    let data = try! decoder.decode([String: Student].self, from: backupDictionary)
    Student.students = data
}
