//
//  CarInfo.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct CarParts: Codable {
    let engineOil: PartsInfo
    let missionOil: PartsInfo
    let brakeOil: PartsInfo
    let brakePad: PartsInfo
    let tire: PartsInfo
    let tireRotation: PartsInfo
    let fuelFilter: PartsInfo
    let wiper: PartsInfo
    let airconFilter: PartsInfo
    let insurance: PartsInfo
    
    let userEmail: String?
}

struct PartsInfo: Codable {
    let currentTime: Date?
    let fixChange: [FixHistory?]
}

struct FixHistory: Codable {
    let changedDate: Date?
    let changedType: FixChange?
}

enum FixChange: Codable {
    case dateFix //날짜 변경
    case changes //점검 완료? 점검 후 변경
}
