import FirebaseAuth
import UIKit

struct Constants {
    static let horizontalMargin: CGFloat = 16.0
    static let verticalMargin: CGFloat = 12.0
    static let cornerRadius: CGFloat = 5.0

    static let fontJua10 = UIFont(name: "Jua", size: 10)
    static let fontJua14 = UIFont(name: "Jua", size: 14)
    static let fontJua16 = UIFont(name: "Jua", size: 16)
    static let fontJua20 = UIFont(name: "Jua", size: 20)
    static let fontJua24 = UIFont(name: "Jua", size: 24)
    static let fontJua28 = UIFont(name: "Jua", size: 28)
    static let fontJua32 = UIFont(name: "Jua", size: 32)
    static let fontJua36 = UIFont(name: "Jua", size: 36)
    static let fontJua40 = UIFont(name: "Jua", size: 40)
    
    static var carParts = CarPart(engineOil: PartsInfo(currentTime: "", fixHistory: []), missionOil: PartsInfo(currentTime: "", fixHistory: []), brakeOil: PartsInfo(currentTime: "", fixHistory: []), brakePad: PartsInfo(currentTime: "", fixHistory: []), tire: PartsInfo(currentTime: "", fixHistory: []), tireRotation: PartsInfo(currentTime: "", fixHistory: []), fuelFilter: PartsInfo(currentTime: "", fixHistory: []), wiper: PartsInfo(currentTime: "", fixHistory: []), airconFilter: PartsInfo(currentTime: "", fixHistory: []), insurance: PartsInfo(currentTime: "", fixHistory: []), userEmail: Auth.auth().currentUser?.email)
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

struct Menu {
    let title: String
    let interval: String
    let icon: UIImage
}

enum componentsType: Codable {
    case engineOil
    case missionOil
    case brakeOil
    case brakePad
    case tireRotation
    case tire
    case fuelFilter
    case wiperBlade
    case airconFilter
    case insurance
}
