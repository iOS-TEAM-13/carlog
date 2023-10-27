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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        addTargets()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginView.endEditing(true)
    }

    func setupUI() {
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview() // LoginPageProperties 뷰를 슈퍼뷰에 맞게 설정
        }
        loginView.passwordTextField.isSecureTextEntry = true
    }

    func addTargets() {
        loginView.emailTextField.addAction(UIAction(handler: { _ in self.textFieldDidChange() }), for: .editingChanged)
        loginView.passwordTextField.addAction(UIAction(handler: { _ in self.textFieldDidChange() }), for: .editingChanged)
        loginView.loginButton.addAction(UIAction(handler: { _ in
            guard let email = self.loginView.emailTextField.text, let password = self.loginView.passwordTextField.text else { return }

            LoginService.loginService.loginUser(email: email, password: password) { isSuccess, error in
                if isSuccess {
                    let tabBarController = Util.mainTabBarController()
                    if let windowScene = UIApplication.shared.connectedScenes
                        .first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                        let window = windowScene.windows.first
                    {
                        window.rootViewController = tabBarController
                    }
                } else {
                    if error != nil {
                        // 로그인 실패 시 에러 메시지 표시
                        let alert = UIAlertController(title: "로그인 실패", message: "이메일과 비밀번호를 다시 입력해주세요", preferredStyle: .alert)
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
        }), for: .touchUpInside)
        loginView.joinupButton.addAction(UIAction(handler: { _ in
            let joinPageViewController = JoinupPageViewController()
            joinPageViewController.modalPresentationStyle = .fullScreen
            self.present(joinPageViewController, animated: true, completion: nil)
        }), for: .touchUpInside)
    }

    func textFieldDidChange() {
        let isEmailValid = loginView.emailTextField.text?.isValidEmail() ?? false
        let isPasswordValid = loginView.passwordTextField.text?.isValidPassword() ?? false

        UIView.animate(withDuration: 0.3) {
            if isEmailValid && isPasswordValid {
                self.loginView.loginButton.isEnabled = true
                self.loginView.loginButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                self.loginView.loginButton.backgroundColor = .mainNavyColor
            }
        }
    }
}
