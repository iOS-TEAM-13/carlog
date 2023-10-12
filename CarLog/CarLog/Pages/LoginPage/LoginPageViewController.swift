import UIKit

import SnapKit

class LoginPageViewController: UIViewController {
    let properties = LoginPageProperties()
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(properties)
        properties.snp.makeConstraints { make in
            make.edges.equalToSuperview() // LoginPageProperties 뷰를 슈퍼뷰에 맞게 설정
        }
        
        // MARK - addTarget
        properties.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        properties.checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let tabBarController = TabBarController()
        navigationController?.setViewControllers([tabBarController], animated: false)
        
        let tabs: [(root: UIViewController, icon: String)] = [
            (MyCarPageViewController(), "car"),
            (HistoryPageViewController(), "book"),
            (MapPageViewController(), "map"),
            (CommunityPageViewController(), "play"),
            (MyPageViewController(), "person")
        ]
        
        tabBarController.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }, animated: false)
    }
    
    @objc func checkboxTapped() {
        isChecked = !isChecked
        if isChecked {
            let checkedImage = UIImage(named: "check")
            properties.checkboxButton.setImage(checkedImage, for: .normal)
        } else {
            let uncheckedImage = UIImage(named: "checkbox")
            properties.checkboxButton.setImage(uncheckedImage, for: .normal)
        }
    }
}
