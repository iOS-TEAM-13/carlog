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
}
