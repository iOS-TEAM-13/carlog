import UIKit

struct Constants {
    static let horizontalMargin: CGFloat = 20.0
    static let verticalMargin: CGFloat = 10.0

    static let fontJua10 = UIFont(name: "Jua", size: 10)
    static let fontJua16 = UIFont(name: "Jua", size: 16)
    static let fontJua20 = UIFont(name: "Jua", size: 20)
    static let fontJua24 = UIFont(name: "Jua", size: 24)
    static let fontJua36 = UIFont(name: "Jua", size: 36)
    
    enum CheckView {
        case engineView
        case missionOilView
        case brakeOilView
        case brakePadView
        case tireRotationView
        case tireView
        case filterView
        case wiperView
        case airconFilterView
        case insuranceView
    }
}
