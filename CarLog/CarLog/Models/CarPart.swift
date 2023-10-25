//
//  CarInfo.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import Foundation

struct CarPart: Codable {
    var parts: [PartsInfo]
    var userEmail: String?
}

struct PartsInfo: Codable {
    let name: componentsType
    var currentTime: String?
    var currentTimeToMonth: Int? {
        switch currentTime {
        case "모르겠어요":
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
        case "1","2","3","4","5","6","7","8","9","10","11","12":
            guard let time = currentTime else { return 0}
            return Int(time)
        default:
            guard let time = currentTime?.components(separatedBy: ".")[1] else { return 0 }
            let nowTime = Date().toString().components(separatedBy: ".")[1]
            if time > nowTime {
                return 12 - (Int(time) ?? 0 - (Int(nowTime) ?? 0))
            } else {
                guard let time = Int(time) else { return 0 }
                guard let nowTime = Int(nowTime) else { return 0 }
                return nowTime - time
            }
        }
    }
    var fixHistory: [FixHistory?]
}

struct FixHistory: Codable {
    let changedDate: Date?
    let changedType: ChangedType?
}

enum ChangedType: String, Codable {
    case isModifiedDate = "날짜수정"
    case isFixedParts = "교체완료"
}
