import UIKit

import SnapKit

class LoginPageViewController: UIViewController {
    let loginView = LoginView()
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
    }

    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // LoginPageProperties 뷰를 슈퍼뷰에 맞게 설정
        }

        // MARK: - addTarget
        loginView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        loginView.joinupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldDidChange(){
        let userEmail = "1@test.com"
        let userPassword = "1234"

        if loginView.emailTextField.text == userEmail && loginView.passwordTextField.text == userPassword {
            loginView.loginButton.isEnabled = true
        } else {
            loginView.loginButton.isEnabled = false
        }

        
        UIView.animate(withDuration: 0.3) {
            if self.loginView.loginButton.isEnabled {
                self.view.layoutIfNeeded()
                self.loginView.loginButton.setTitleColor(.white, for: .normal)
                self.loginView.loginButton.backgroundColor = .primaryColor
            } else {
                self.view.layoutIfNeeded()
                self.loginView.loginButton.setTitleColor(.primaryColor, for: .normal)
                self.loginView.loginButton.backgroundColor = .thirdColor
            }
        }
    }

    @objc func loginButtonTapped() {
        let tabBarController = TabBarController()

        let tabs: [(root: UIViewController, icon: String)] = [
            (MyCarPageViewController(), "car"),
            (HistoryPageViewController(), "book"),
            (MapPageViewController(), "map"),
            (MyCarDetailPageViewController(), "play"),
            (MyPageViewController(), "person"),
        ]

        tabBarController.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }, animated: false)

        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }

    @objc func signupButtonTapped() {
        let joinPageViewController = JoinupPageViewController()
        joinPageViewController.modalPresentationStyle = .fullScreen
        present(joinPageViewController, animated: true, completion: nil)
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
