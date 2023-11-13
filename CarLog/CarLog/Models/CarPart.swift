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

//struct PartsInfo: Codable {
//    let name: componentsType
//    var currentTime: String?
//    var currentTimeToMonth: Int? {
//        switch currentTime {
//        case "모르겠어요":
//            return 0
//        case "최근":
//            return 0
//        case "1개월 전":
//            return 1
//        case "3개월 전":
//            return 3
//        case "6개월 전":
//            return 6
//        case "1년 전":
//            return 12
//        case "2년 전":
//            return 24
//        case "3년 전":
//            return 36
//        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12":
//            guard let time = currentTime else { return 0 }
//            return Int(time)
//        default:
//            guard let time = currentTime?.components(separatedBy: ".")[1] else { return 0 }
//            let nowTime = Date().toString().components(separatedBy: ".")[1]
//            if time > nowTime {
//                return 12 - (Int(time) ?? 0 - (Int(nowTime) ?? 0))
//            } else {
//                guard let time = Int(time) else { return 0 }
//                guard let nowTime = Int(nowTime) else { return 0 }
//                return nowTime - time
//            }
//        }
//    }
//    var fixHistory: [FixHistory?]
//}

struct PartsInfo: Codable {
    let name: componentsType
    var currentTime: String?
    var startTime: Date? {
        let calendar = Calendar.current
        switch currentTime {
        case "모르겠어요":
            return Date()
        case "최근":
            return Date()
        case "1개월 전":
            return calendar.date(byAdding: .month, value: -1, to: Date())
        case "3개월 전":
            return calendar.date(byAdding: .month, value: -3, to: Date())
        case "6개월 전":
            return calendar.date(byAdding: .month, value: -6, to: Date())
        case "1년 전":
            return calendar.date(byAdding: .year, value: -1, to: Date())
        case "2년 전":
            return calendar.date(byAdding: .year, value: -2, to: Date())
        case "3년 전":
            return calendar.date(byAdding: .year, value: -3, to: Date())
        case "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12":
            return calendar.date(byAdding: .year, value: Int(currentTime ?? "") ?? 0, to: Date())
//        default:
//            if calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0 > calendar.dateComponents([.month], from: Date()).month ?? 0 {
//                return calendar.date(byAdding: .month, value: -(12 - (calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0) + (calendar.dateComponents([.month], from: Date()).month ?? 0)), to: Date())
//            } else {
//                return calendar.date(byAdding: .month, value: -((calendar.dateComponents([.month], from: Date()).month ?? 0) - (calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0)), to: Date())
//            }
//        }
        default:
            var newDate: Date?
            if calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0 > calendar.dateComponents([.month], from: Date()).month ?? 0 {
                newDate = calendar.date(byAdding: .month, value: -(12 - (calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0) + (calendar.dateComponents([.month], from: Date()).month ?? 0)), to: Date())
            } else {
                newDate = calendar.date(byAdding: .month, value: -((calendar.dateComponents([.month], from: Date()).month ?? 0) - (calendar.dateComponents([.month], from: (currentTime?.toDate()) ?? Date()).month ?? 0)), to: Date())
            }

            let currentDay = calendar.component(.day, from: currentTime?.toDate() ?? Date())
                var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate ?? Date())
                components.day = currentDay
                return calendar.date(from: components)
        }
    }
    var endTime: Date? {
        let calendar = Calendar.current
        switch name {
        case .engineOil:
            return calendar.date(byAdding: .month, value: 6, to: startTime ?? Date())
        case .missionOil:
            return calendar.date(byAdding: .year, value: 2, to: startTime ?? Date())
        case .brakeOil:
            return calendar.date(byAdding: .year, value: 2, to: startTime ?? Date())
        case .brakePad:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        case .tireRotation:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        case .tire:
            return calendar.date(byAdding: .year, value: 3, to: startTime ?? Date())
        case .fuelFilter:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        case .wiperBlade:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        case .airconFilter:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        case .insurance:
            return calendar.date(byAdding: .year, value: 1, to: startTime ?? Date())
        }
    }
    
    //    func toInterval(seletedDate: Int, type: componentsType) -> Date {
    //        let currentDate = Date()
    //        let calendar = Calendar.current
    //        var value = 0
    //        switch type {
    //        case .engineOil:
    //            value = 6 - seletedDate
    //        case .missionOil:
    //            value = 24 - seletedDate
    //        case .brakeOil:
    //            value = 24 - seletedDate
    //        case .brakePad:
    //            value = 12 - seletedDate
    //        case .tireRotation:
    //            value = 12 - seletedDate
    //        case .tire:
    //            value = 36 - seletedDate
    //        case .fuelFilter:
    //            value = 12 - seletedDate
    //        case .wiperBlade:
    //            value = 12 - seletedDate
    //        case .airconFilter:
    //            value = 12 - seletedDate
    //        case .insurance:
    //            value = 12 - seletedDate
    //        }
    //        guard let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) else { return Date() }
    //        return newDate
    //    }
    
    var fixHistory: [FixHistory?]
}

struct FixHistory: Codable {
    let changedDate: Date?
    let newDate: Date?
    let changedType: ChangedType?
}

enum ChangedType: String, Codable {
    case isModifiedDate = "날짜수정"
    case isFixedParts = "교체완료"
}
