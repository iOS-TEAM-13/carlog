import SwiftSMTP
import UIKit

extension JoinupPageViewController {
    // MARK: - 회원가입의 주요 기능 구현 코드
    func addJoinUserFieldActions() {
        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            if self.joinupView.emailTextField.text?.isEmpty == true {
                self.joinupView.emailAlertLabel.isHidden = false
            }
        }), for: .editingDidBegin)

        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)

        joinupView.passwordTextField.addAction(UIAction(handler: { _ in
            if self.joinupView.passwordTextField.text?.isEmpty == true {
                self.joinupView.passwordAlertLabel.isHidden = false
            }
        }), for: .editingDidBegin)

        joinupView.passwordTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)

        joinupView.confirmPasswordTextField.addAction(UIAction(handler: { _ in
            if self.joinupView.confirmPasswordTextField.text?.isEmpty == true {
                self.joinupView.confirmPasswordAlertLabel.isHidden = false
            }
        }), for: .editingDidBegin)

        joinupView.confirmPasswordTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)
    }

    func addCheckEmailButtonAction() {
        joinupView.checkEmailButton.addAction(UIAction(handler: { _ in
            guard let emailToCheck = self.joinupView.emailTextField.text, !emailToCheck.isEmpty, emailToCheck.isValidEmail() else {
                return self.showAlert(message: "올바른 이메일 형식이 아닙니다")
            }

            FirestoreService.firestoreService.checkingEmail(email: emailToCheck) { isEmailAvailable, error in
                if let error = error {
                    print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                    return
                }

                if isEmailAvailable {
                    self.joinupView.checkEmailButton.setTitleColor(.primaryColor, for: .normal)
                    self.joinupView.checkEmailButton.setTitle("가능", for: .normal)
                } else {
                    self.joinupView.checkEmailButton.setTitleColor(.red, for: .normal)
                    self.joinupView.checkEmailButton.setTitle("불가능", for: .normal)
                    self.showAlert(message: "이미 사용중인 아이디입니다")
                    self.joinupView.emailTextField.text = ""
                }
            }
        }), for: .touchUpInside)
    }

    func addSMTPButtonAction() {
        joinupView.smtpButton.addAction(UIAction(handler: { _ in
            guard self.joinupView.smtpEmailTextField.text != nil else {
                let alert = UIAlertController(title: "오류", message: "유효하지 않은 이메일 형식입니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true)
                print("유효하지 않은 이메일 형식입니다.")
                return
            }

            // smtp 로직
            let smtp = SMTP(hostname: "smtp.gmail.com", email: "user3rum@gmail.com", password: "ciihfefuexaihugu")

            let from = Mail.User(name: "CarLog", email: "user3rum@gmail.com")
            let to = Mail.User(name: "User", email: self.joinupView.smtpEmailTextField.text!)

            let code = "\(Int.random(in: 100000 ... 999999))"

            let mail = Mail(from: from, to: [to], subject: "[CarLog] E-MAIL VERIFICATION", text: "인증번호 \(code) \n" + "APP으로 돌아가 인증번호를 입력해주세요.")

            smtp.send(mail) { error in
                if let error = error {
                    print("전송에 실패하였습니다.: \(error)")
                } else {
                    print("전송에 성공하였습니다!")
                    UserDefaults.standard.set(code, forKey: "emailVerificationCode")
                }
            }
            self.joinupView.smtpTimerLabel.isHidden = false

            // 타이머
            if self.timer == nil {
                // 타이머 시작
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
            }
        }), for: .touchUpInside)
    }

    func addSMTPNumberButtonAction() {
        joinupView.smtpNumberButton.addAction(UIAction(handler: { _ in
            self.checkVerificationCode()
        }), for: .touchUpInside)
    }

    func addJoinInButtonAction() {
        joinupView.joinInButton.addAction(UIAction(handler: { _ in
            if self.joinupView.checkEmailButton.title(for: .normal) != "가능" {
                self.showAlert(message: "아이디 중복검사를 해주세요")
                return
            }
            guard let email = self.joinupView.emailTextField.text,
                  let password = self.joinupView.passwordTextField.text,
                  let confirmPassword = self.joinupView.confirmPasswordTextField.text
            else {
                return
            }

            let isEmailValid = email.isValidEmail()
            let isPasswordValid = password.isValidPassword()
            let isConfirmPasswordValid = confirmPassword == password

            if isEmailValid, isPasswordValid, isConfirmPasswordValid {
                // 모든 조건을 만족하면 다음 단계로 이동
                self.view.addSubview(self.carNumberView)
                self.joinupView.isHidden = true
                self.carNumberView.isHidden = false
                self.carNumberView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            } else {
                // 조건을 만족하지 않을 때 경고 표시
                var alertMessage = ""
                if !isEmailValid {
                    alertMessage = "올바른 이메일 형식으로 써주세요"
                } else if !isPasswordValid {
                    alertMessage = "올바른 비밀번호를 써주세요 (대/소문자,특수기호,8글자이상)"
                } else if !isConfirmPasswordValid {
                    alertMessage = "비밀번호와 다릅니다, 다시 입력해주세요"
                }
                self.showAlert(message: alertMessage)
            }
        }), for: .touchUpInside)
    }

    // MARK: - SMTP 인증관련 코드
    func checkVerificationCode() {
        guard let userInputCode = joinupView.smtpNumberTextField.text else {
            return
        }

        if let savedCode = UserDefaults.standard.string(forKey: "emailVerificationCode"), savedCode == userInputCode {
            showAlert(message: "인증에 성공하였습니다!")

            joinupView.smtpTimerLabel.isHidden = true
            joinupView.smtpNumberTextField.isHidden = true
            joinupView.smtpNumberButton.isHidden = true
        } else {
            showAlert(message: "인증번호가 일치하지 않습니다.")
        }
    }

    func verifyButtonPressed(_ sender: UIButton) {
        checkVerificationCode()
    }

    @objc func updateTimerLabel() {
        if seconds > 0 {
            seconds -= 1
            joinupView.smtpTimerLabel.text = timeString(time: TimeInterval(seconds))
        } else {
            timer?.invalidate()
            timer = nil
            joinupView.smtpNumberButton.isEnabled = false
        }
    }

    func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }

    // MARK: - View 관련 로직 + 회원가입할 때 기능 구현
    func forHiddenViews() {
        joinupView.popButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)

        carNumberView.popButton.addAction(UIAction(handler: { _ in
            self.joinupView.isHidden = false
            self.carNumberView.isHidden = true
        }), for: .touchUpInside)

        carNumberView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carMakerView)
            self.carNumberView.isHidden = true
            self.carMakerView.isHidden = false
            self.carMakerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        carMakerView.popButton.addAction(UIAction(handler: { _ in
            self.carNumberView.isHidden = false
            self.carMakerView.isHidden = true
        }), for: .touchUpInside)

        carMakerView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carModelView)
            self.carMakerView.isHidden = true
            self.carModelView.isHidden = false
            self.carModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        carModelView.popButton.addAction(UIAction(handler: { _ in
            self.carMakerView.isHidden = false
            self.carModelView.isHidden = true
        }), for: .touchUpInside)

        carModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.oilModelView)
            self.carModelView.isHidden = true
            self.oilModelView.isHidden = false
            self.oilModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)

        oilModelView.popButton.addAction(UIAction(handler: { _ in
            self.carModelView.isHidden = false
            self.oilModelView.isHidden = true
        }), for: .touchUpInside)
        oilModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.nickNameView)
            self.oilModelView.isHidden = true
            self.nickNameView.isHidden = false
            self.nickNameView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        nickNameView.popButton.addAction(UIAction(handler: { _ in
            self.oilModelView.isHidden = false
            self.nickNameView.isHidden = true
        }), for: .touchUpInside)
        nickNameView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.totalDistanceView)
            self.nickNameView.isHidden = true
            self.totalDistanceView.isHidden = false
            self.totalDistanceView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        totalDistanceView.popButton.addAction(UIAction(handler: { _ in
            self.nickNameView.isHidden = false
            self.totalDistanceView.isHidden = true
        }), for: .touchUpInside)
        totalDistanceView.nextButton.addAction(UIAction(handler: { _ in
            LoginService.loginService.signUpUser(email: self.joinupView.emailTextField.text ?? "", password: self.joinupView.passwordTextField.text ?? "")

            let selectedOilType = self.oilModelView.selectedOil

            FirestoreService.firestoreService.saveCar(
                car: Car(
                    number: self.carNumberView.carNumberTextField.text,
                    maker: self.carMakerView.carMakerTextField.text,
                    name: self.carModelView.carModelTextField.text,
                    oilType: selectedOilType ?? "",
                    nickName: self.nickNameView.carNickNameTextField.text,
                    totalDistance: Double(self.totalDistanceView.totalDistanceTextField.text ?? "") ?? 0.0,
                    userEmail: self.joinupView.emailTextField.text),
                completion: { _ in })
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
}
