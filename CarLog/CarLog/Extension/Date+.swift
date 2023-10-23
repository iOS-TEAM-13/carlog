//
//  Date+.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/19.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
