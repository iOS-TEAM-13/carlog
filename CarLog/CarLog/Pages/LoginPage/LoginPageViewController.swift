import UIKit

import SnapKit

class LoginPageViewController: UIViewController {
    let loginView = LoginView()
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // LoginPageProperties 뷰를 슈퍼뷰에 맞게 설정
        }
        
        // MARK - addTarget
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        loginView.joinupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
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
    
    @objc func signupButtonTapped() {
        let joinPage = JoinupPageViewController()
        navigationController?.pushViewController(joinPage, animated: false)
    }
    
    @objc func checkboxTapped() {
        isChecked = !isChecked
        if isChecked {
            let checkedImage = UIImage(named: "check")
            loginView.checkboxButton.setImage(checkedImage, for: .normal)
        } else {
            let uncheckedImage = UIImage(named: "checkbox")
            loginView.checkboxButton.setImage(uncheckedImage, for: .normal)
        }
    }
}
