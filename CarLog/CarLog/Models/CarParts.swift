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
    let currentTime: String?
    var currentTimeToMonth: Int? {
        switch currentTime {
        case "모르겠음":
            return 0
        case "최근":
            return 0
        case "1개월 전":
            return 1
        case "3개월 전":
            return 3
        case "6개월 전":
            return 6
        case "1년 전":
            return 12
        case "2년 전":
            return 24
        case "3년 전":
            return 36
        default:
            return 0
        }
    }
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
