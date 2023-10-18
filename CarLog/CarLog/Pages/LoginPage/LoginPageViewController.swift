import UIKit

import AuthenticationServices
import FirebaseAuth
import SnapKit

class LoginPageViewController: UIViewController {
    let loginView = LoginView()
    var isChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        keepLogin()
    }

    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // LoginPageProperties 뷰를 슈퍼뷰에 맞게 설정
        }
        loginView.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginView.joinupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        loginView.appleLoginButton.addTarget(self, action: #selector(appleLogInTapped), for: .touchUpInside)
    }

    @objc func textFieldDidChange() {
        let isEmailValid = loginView.emailTextField.text?.isValidEmail() ?? false
        let isPasswordValid = loginView.passwordTextField.text?.isValidPassword() ?? false

        UIView.animate(withDuration: 0.3) {
            if isEmailValid && isPasswordValid {
                self.loginView.loginButton.isEnabled = true
                self.loginView.loginButton.setTitleColor(.white, for: .normal)
                self.loginView.loginButton.backgroundColor = .primaryColor
            } else {
                self.loginView.loginButton.isEnabled = false
                self.loginView.loginButton.setTitleColor(.primaryColor, for: .normal)
                self.loginView.loginButton.backgroundColor = .thirdColor
            }
        }
    }

    @objc func loginButtonTapped() {
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text else { return }

        LoginService.loginService.loginUser(email: email, password: password) { isSuccess, error in
            if isSuccess {
            } else {
                if error != nil {
                    // 로그인 실패 시 에러 메시지 표시
                    let alert = UIAlertController(title: "로그인 실패", message: "로그인과 비밀번호를 다시 입력해주세요", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // 에러가 Firebase에서 반환되지 않은 경우 에러 메시지 표시
                    let alert = UIAlertController(title: "로그인 실패", message: "서버가 연결되지 않았습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func appleLogInTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    @objc func signupButtonTapped() {
        let joinPageViewController = JoinupPageViewController()
        joinPageViewController.modalPresentationStyle = .fullScreen
        present(joinPageViewController, animated: true, completion: nil)
    }

    func mainTabBarController() -> UITabBarController {
        let tabBarController = TabBarController()

        let tabs: [(root: UIViewController, icon: String)] = [
            (MyCarPageViewController(), "car"),
            (HistoryPageViewController(), "book"),
            (MapPageViewController(), "map"),
            (CommunityPageViewController(), "play"),
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

    func keepLogin() {
        LoginService.loginService.keepLogin { user in
            print("user:\(user?.email ?? "")")
            if user != nil {
                let tabBarController = self.mainTabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
}

extension LoginPageViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
                
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")

        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    
    }
}
