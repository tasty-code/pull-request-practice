//
//  ReportCard.swift
//  MyCreditManager_2_kbs96117
//
//  Created by BOMBSGIE on 2023/08/17.
//

import Foundation

struct ReportCard: Codable {
    var sudentName: String
    var reports: [String: Grade]
}

