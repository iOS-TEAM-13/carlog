import UIKit

import FirebaseAuth

struct Constants {
    static let horizontalMargin: CGFloat = 16.0
    static let verticalMargin: CGFloat = 12.0
    static let cornerRadius: CGFloat = 5.0

    static let fontJua10: CGFloat = 10
    static let fontJua14: CGFloat = 14
    static let fontJua16: CGFloat = 16
    static let fontJua20: CGFloat = 20
    static let fontJua24: CGFloat = 24
    static let fontJua28: CGFloat = 28
    static let fontJua32: CGFloat = 32
    static let fontJua36: CGFloat = 36
    static let fontJua40: CGFloat = 40

    static var carParts = CarPart(parts: [PartsInfo(name: .engineOil, fixHistory: []), PartsInfo(name: .missionOil, fixHistory: []), PartsInfo(name: .brakeOil, fixHistory: []), PartsInfo(name: .brakePad, fixHistory: []), PartsInfo(name: .tireRotation, fixHistory: []), PartsInfo(name: .tire, fixHistory: []), PartsInfo(name: .fuelFilter, fixHistory: []), PartsInfo(name: .wiperBlade, fixHistory: []), PartsInfo(name: .airconFilter, fixHistory: []), PartsInfo(name: .insurance, fixHistory: [])], userEmail: "")
}

enum componentsType: String, Codable {
    case engineOil = "엔진 오일"
    case missionOil = "미션 오일"
    case brakeOil = "브레이크 오일"
    case brakePad = "브레이크 패드"
    case tireRotation = "타이어 로테이션"
    case tire = "타이어 교체"
    case fuelFilter = "연료 필터"
    case wiperBlade = "와이퍼 블레이드"
    case airconFilter = "에어컨 필터"
    case insurance = "보험"
}
