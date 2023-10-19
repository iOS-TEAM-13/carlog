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
    let fixHistory: [FixHistory?]
}

struct FixHistory: Codable {
    let changedDate: Date?
    let changedType: ChangedType?
}

enum ChangedType: String, Codable {
    case isModifiedDate = "날짜수정"
    case isFixedParts = "교체완료"
}
