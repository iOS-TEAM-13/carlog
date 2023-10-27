import UIKit

import FirebaseAuth
import FirebaseFirestore
import SnapKit

class JoinupPageViewController: UIViewController {
    let joinupView = JoinupView()
    let carNumberView = CarNumberView()
    let carMakerView = CarMakerView()
    let carModelView = CarModelView()
    let oilModelView = OilModelView()
    let nickNameView = NickNameView()
    let totalDistanceView = TotalDistanceView()

    var timer: Timer?
    var seconds: Int = 180
    var isChecked = false
    let dummyData = ["휘발유", "경유", "LPG"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        joinupView.joinInButton.isEnabled = false
        setupUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func setupUI() {
        view.addSubview(joinupView) // 첫 view
        forHiddenViews() // 다음 버튼들의 숨겨진 views
        registerForKeyboardNotifications() // 키보드 기능들
        addTargets() // 기능 구현 한 곳

        joinupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func addTargets() {
        addJoinUserFieldActions()
        addCheckEmailButtonAction()
        addSMTPButtonAction()
        addSMTPNumberButtonAction()
        addJoinInButtonAction()
        personalInfoVerifiedCheck()
    }

    // MARK: - Alert 창 구현

    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: 텍스트 필드 변경 관련

    func textFieldDidChange() {
        let isEmailValid = joinupView.emailTextField.text?.isValidEmail() ?? false
        let isPasswordValid = joinupView.passwordTextField.text?.isValidPassword() ?? false
        let isConfirmPassword = joinupView.confirmPasswordTextField.text?.isValidPassword() ?? false
        let isSMTPEmailValid = joinupView.smtpEmailTextField.text?.isValidEmail() ?? false
        let isSMTPNumber = joinupView.smtpNumberTextField.text?.count == 6

        UIView.animate(withDuration: 0.3) {
            if isEmailValid, isPasswordValid, isConfirmPassword, isSMTPEmailValid, isSMTPNumber {
                self.joinupView.joinInButton.isEnabled = true
                self.joinupView.joinInButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                self.joinupView.joinInButton.backgroundColor = .mainNavyColor
            } else {
                self.joinupView.joinInButton.isEnabled = false
                self.joinupView.joinInButton.setTitleColor(.gray, for: .normal) // 비활성화 시 글자 색 변경
                self.joinupView.joinInButton.backgroundColor = .lightGray // 비활성화 시 배경색 변경
            }
        }
    }

    // MARK: - Keyboard 관련

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        let lists: [UIView] = [carNumberView, carModelView, nickNameView, totalDistanceView]
        let buttonLists: [UIView] = [carNumberView.nextButton, carModelView.nextButton, nickNameView.nextButton, totalDistanceView.nextButton]

        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }

        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: keyboardFrame.size.height,
            right: 0.0)
        joinupView.scrollView.contentInset = contentInset
        joinupView.scrollView.scrollIndicatorInsets = contentInset

        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        {
            let keyboardHeight = keyboardFrame.height
            for buttonList in buttonLists {
                let textFieldFrameInWindow = buttonList.convert(buttonList.bounds, to: nil)
                let maxY = textFieldFrameInWindow.maxY
                for list in lists {
                    if maxY > (list.frame.size.height - keyboardHeight) {
                        let scrollOffset = maxY - (list.frame.size.height - keyboardHeight)
                        list.frame.origin.y = scrollOffset - 100
                    }
                }
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInset = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0.0,
            right: 0.0)
        joinupView.scrollView.contentInset = contentInset
        joinupView.scrollView.scrollIndicatorInsets = contentInset
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        joinupView.endEditing(true)
        carNumberView.endEditing(true)
        carModelView.endEditing(true)
        oilModelView.endEditing(true)
        nickNameView.endEditing(true)
        totalDistanceView.endEditing(true)
    }
}

