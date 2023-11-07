//
//  Int+.swift
//  CarLog
//
//  Created by 김지훈 on 11/7/23.
//

import Foundation

extension Int {
    
    //숫자 세자리마다 콤마찍기
    func stringToInt() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
    //콤마 있는 스트링값 콤마 제거하기
    //    func intToString(formattedString: String) -> Int? {
    //        let numberFormatter = NumberFormatter()
    //        numberFormatter.numberStyle = .none
    //
    //        if let number = numberFormatter.number(from: formattedString) {
    //            return number.intValue
    //        }
    //
    //        return nil
    //    }
}
