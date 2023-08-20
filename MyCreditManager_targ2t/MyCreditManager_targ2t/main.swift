//
//  main.swift
//  MyCreditManager_targ2t
//
//  Created by 김보미 on 2022/12/05.
//

/// [2022 맛있는코드 x 새싹] iOS 앱 개발자 부트캠프 사전과제
/// 성적 관리 프로그램 (Console)
///
/// Command Line Tool

import Foundation

/// 앱 작업 시 ContentView를 깔끔하게 사용하려고 하는 것처럼 main.swift도 깔끔하게 유지하기 위해
/// 클래스와 구조체를 파일로 분리하는 것이 필요하다.
let creditManager = CreditManager()

creditManager.creditManager()
