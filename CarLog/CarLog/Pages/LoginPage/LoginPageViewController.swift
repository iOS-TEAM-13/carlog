import UIKit

class LoginPageViewController: UIViewController {
    let properties = LoginPageProperties()
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryColor
        setupUI()
    }
    
    func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(properties.logo)
        view.addSubview(properties.emailTextField)
        view.addSubview(properties.passwordTextField)
        view.addSubview(properties.loginStatusStackView)
        view.addSubview(properties.loginButton)
        
        properties.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        properties.checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        properties.logo.translatesAutoresizingMaskIntoConstraints = false
        properties.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        properties.passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        properties.loginStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        properties.loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            properties.logo.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            properties.logo.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 85),
            properties.logo.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
        // emailTextField 설정
        NSLayoutConstraint.activate([
            properties.emailTextField.topAnchor.constraint(equalTo: properties.logo.bottomAnchor, constant: 10),
            properties.emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            properties.emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
            
        // passwordTextField 설정
        NSLayoutConstraint.activate([
            properties.passwordTextField.topAnchor.constraint(equalTo: properties.emailTextField.bottomAnchor, constant: 10),
            properties.passwordTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            properties.passwordTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
        // checkbox
        NSLayoutConstraint.activate([
            properties.loginStatusStackView.topAnchor.constraint(equalTo: properties.passwordTextField.bottomAnchor, constant: 15),
            properties.loginStatusStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15)
        ])
            
        // loginButton 설정
        NSLayoutConstraint.activate([
            properties.loginButton.topAnchor.constraint(equalTo: properties.passwordTextField.bottomAnchor, constant: 60),
            properties.loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            properties.loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            properties.loginButton.widthAnchor.constraint(equalToConstant: 100),
            properties.loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
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
