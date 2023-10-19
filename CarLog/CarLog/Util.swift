//
//  Util.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/20.
//

import Foundation

class Util {
    static let util = Util()
    
    func toInterval(seletedDate: Int, type: String) -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        var value = 0
        print("@@@ \(type)")
        switch type {
        case "엔진 오일":
            value = 6 - seletedDate
        case "미션 오일":
            value = 24 - seletedDate
        case "브레이크 오일":
            value = 24 - seletedDate
        case "브레이크 패드":
            value = 12 - seletedDate
        case "타이어 로테이션":
            value = 12 - seletedDate
        case "타이어 교체":
            value = 36 - seletedDate
        case "연료 필터":
            value = 12 - seletedDate
        case "와이퍼 블레이드":
            value = 12 - seletedDate
        case "에어컨 필터":
            value = 12 - seletedDate
        case "보험":
            value = 12 - seletedDate
        default:
            break
        }
        guard let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) else { return Date() }
        return newDate
    }
    
    func toInterval(seletedDate: Int) -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        guard let newDate = calendar.date(byAdding: .month, value: -seletedDate, to: currentDate) else { return Date() }
        return newDate
    }
}
