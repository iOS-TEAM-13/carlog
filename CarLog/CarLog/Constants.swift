import FirebaseAuth
import UIKit

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
    
    static var carParts = CarPart(engineOil: PartsInfo(currentTime: "", fixHistory: []), missionOil: PartsInfo(currentTime: "", fixHistory: []), brakeOil: PartsInfo(currentTime: "", fixHistory: []), brakePad: PartsInfo(currentTime: "", fixHistory: []), tire: PartsInfo(currentTime: "", fixHistory: []), tireRotation: PartsInfo(currentTime: "", fixHistory: []), fuelFilter: PartsInfo(currentTime: "", fixHistory: []), wiper: PartsInfo(currentTime: "", fixHistory: []), airconFilter: PartsInfo(currentTime: "", fixHistory: []), insurance: InsuranceInfo(currentTime: "", fixHistory: []), userEmail: Auth.auth().currentUser?.email)  
    
    static func mainTabBarController() -> UITabBarController {
        let tabBarController = TabBarController()

        let tabs: [(root: UIViewController, icon: String)] = [
            (MyCarPageViewController(), "car"),
            (HistoryPageViewController(), "book"),
            (MapPageViewController(), "map"),
            //(CommunityPageViewController(), "play"),
            (MyPageViewController(), "person"),
        ]

        tabBarController.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }, animated: false)

        return tabBarController
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
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
