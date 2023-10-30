import UIKit

import FirebaseAuth
import SwiftSMTP

extension JoinupPageViewController {
    // MARK: - 회원가입의 주요 기능 구현 코드
    
    func addJoinUserFieldActions() {
        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            guard let email = self.joinupView.emailTextField.text else {
                self.joinupView.emailAlertLabel.isHidden = false
                return
            }
            
            if email.isEmpty || !email.isValidEmail() {
                self.joinupView.emailAlertLabel.isHidden = false
            } else {
                self.joinupView.emailAlertLabel.isHidden = true
            }
        }), for: .editingDidEnd)
        
        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)
        
        joinupView.passwordTextField.addAction(UIAction(handler: { _ in
            guard let password = self.joinupView.passwordTextField.text else {
                self.joinupView.passwordAlertLabel.isHidden = false
                return
            }
            
            if password.isEmpty || !password.isValidPassword() {
                self.joinupView.passwordAlertLabel.isHidden = false
            } else {
                self.joinupView.passwordAlertLabel.isHidden = true
            }
        }), for: .editingDidEnd)
        
        joinupView.passwordTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)
        
        joinupView.confirmPasswordTextField.addAction(UIAction(handler: { _ in
            guard let password = self.joinupView.confirmPasswordTextField.text else {
                self.joinupView.confirmPasswordAlertLabel.isHidden = false
                return
            }
            
            if password.isEmpty || !password.isValidPassword() {
                self.joinupView.confirmPasswordAlertLabel.isHidden = false
            } else {
                self.joinupView.confirmPasswordAlertLabel.isHidden = true
            }
        }), for: .editingDidEnd)
        
        joinupView.confirmPasswordTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
        }), for: .editingChanged)
        
        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
            if let smtpEmailText = self.joinupView.emailTextField.text, !smtpEmailText.isEmpty, smtpEmailText.isValidEmail() {
                if self.isCheckedEmail == false {
                    self.joinupView.verifiedEmailButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                    self.joinupView.verifiedEmailButton.backgroundColor = .mainNavyColor
                    self.joinupView.verifiedEmailButton.isEnabled = true
                } else {
                    self.joinupView.verifiedEmailButton.setTitleColor(.gray, for: .normal)
                    self.joinupView.verifiedEmailButton.backgroundColor = .lightGray
                    self.joinupView.verifiedEmailButton.isEnabled = false
                    self.isCheckedEmail = true
                }
            }
        }), for: .editingChanged)
        
        joinupView.smtpNumberTextField.addAction(UIAction(handler: { _ in
            self.textFieldDidChange()
            if let smtpNumberText = self.joinupView.smtpNumberTextField.text, !smtpNumberText.isEmpty, smtpNumberText.count == 6 {
                self.joinupView.smtpNumberButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                self.joinupView.smtpNumberButton.backgroundColor = .mainNavyColor
                self.joinupView.smtpNumberButton.isEnabled = true
            } else {
                self.joinupView.smtpNumberButton.setTitleColor(.gray, for: .normal)
                self.joinupView.smtpNumberButton.backgroundColor = .lightGray
                self.joinupView.smtpNumberButton.isEnabled = false
            }
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
                    self.joinupView.checkEmailButton.setTitleColor(.mainNavyColor, for: .normal)
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
        joinupView.verifiedEmailButton.addAction(UIAction(handler: { _ in
            guard let emailText = self.joinupView.emailTextField.text,
                  !emailText.isEmpty,
                  emailText.isValidEmail()
            else {
                self.showAlert(message: "유효하지 않는 이메일 형식이거나 이메일이 비어 있습니다")
                return
            }
            
            // smtp 로직
            let smtp = SMTP(hostname: "smtp.gmail.com", email: "user3rum@gmail.com", password: "ciihfefuexaihugu")
            
            let from = Mail.User(name: "CarLog", email: "user3rum@gmail.com")
            let to = Mail.User(name: "User", email: self.joinupView.emailTextField.text!)
            
            let code = "\(Int.random(in: 100000 ... 999999))"
            
            let mail = Mail(from: from, to: [to], subject: "[CarLog] E-MAIL VERIFICATION", text: "인증번호 \(code) \n" + "APP으로 돌아가 인증번호를 입력해주세요.")
            
            DispatchQueue.global().async {
                smtp.send(mail) { error in
                    if let error = error {
                        print("전송에 실패하였습니다.: \(error)")
                    } else {
                        print("전송에 성공하였습니다!")
                        UserDefaults.standard.set(code, forKey: "emailVerificationCode")
                    }
                }
            }
            
            self.joinupView.smtpTimerLabel.isHidden = false
            self.joinupView.verifiedEmailButton.isEnabled = false
            self.joinupView.verifiedEmailButton.backgroundColor = .lightGray
            self.joinupView.verifiedEmailButton.setTitleColor(.gray, for: .normal)
            self.joinupView.smtpNumberStackView.isHidden = false
            
            // 타이머
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
        }), for: .touchUpInside)
    }
    
    func addSMTPNumberButtonAction() {
        joinupView.smtpNumberButton.addAction(UIAction(handler: { _ in
            self.checkVerificationCode { success in
                if success {
                    self.showAlert(message: "인증이 성공적으로 처리되었습니다")
                    self.joinupView.smtpTimerLabel.isHidden = true
                    self.timer?.invalidate()
                    self.joinupView.smtpNumberButton.setTitle("완료", for: .normal)
                    self.joinupView.verifiedEmailButton.isEnabled = false
                    self.joinupView.verifiedEmailButton.setTitleColor(.gray, for: .normal)
                    self.joinupView.verifiedEmailButton.backgroundColor = .lightGray
                }
            }
        }), for: .touchUpInside)
    }
    
    func addJoinInButtonAction() {
        joinupView.joinInButton.addAction(UIAction(handler: { _ in
            if self.joinupView.checkEmailButton.title(for: .normal) != "가능" {
                self.showAlert(message: "아이디 중복검사를 해주세요")
                return
            }
            
            if self.joinupView.smtpNumberButton.title(for: .normal) != "완료" {
                self.showAlert(message: "인증번호를 확인해주세요")
            }
            
            guard let email = self.joinupView.emailTextField.text,
                  let password = self.joinupView.passwordTextField.text,
                  let confirmPassword = self.joinupView.confirmPasswordTextField.text,
                  //let smtpEmail = self.joinupView.smtpEmailTextField.text,
                  let smtpNumber = self.joinupView.smtpNumberTextField.text
            else {
                return
            }
            
            let isEmailValid = email.isValidEmail()
            let isPasswordValid = password.isValidPassword()
            let isConfirmPasswordValid = confirmPassword == password
            //let isSMTPEmailValid = smtpEmail.isValidEmail()
            let isSMTPNumber = smtpNumber.count == 6
            let personalInfoCheck = self.joinupView.checkboxButton.isSelected == !self.isChecked
            
            if isEmailValid, isPasswordValid, isConfirmPasswordValid, isSMTPNumber, personalInfoCheck {
                LoginService.loginService.signUpUser(email: self.joinupView.emailTextField.text ?? "", password: self.joinupView.passwordTextField.text ?? "")
                // 모든 조건을 만족하면 다음 단계로 이동
                self.checkVerificationCode { success in
                    if success {
                        let alert = UIAlertController(title: "회원가입을 완료하였습니다", message: nil, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                            self.view.addSubview(self.carNumberView)
                            self.joinupView.isHidden = true
                            self.carNumberView.isHidden = false
                            self.carNumberView.snp.makeConstraints { make in
                                make.edges.equalToSuperview()
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        if self.joinupView.smtpNumberTextField.text?.count == 6 {
                            self.joinupView.smtpNumberTextField.text = "" // 6자리이고 일치하지 않으면 입력값 초기화
                            self.showAlert(message: "인증번호가 일치하지 않습니다")
                        }
                    }
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
                } else if smtpNumber.isEmpty {
                    alertMessage = "인증번호를 확인해주세요"
                } else if personalInfoCheck == self.isChecked {
                    alertMessage = "개인정보수집에 동의해주세요"
                }
                self.showAlert(message: alertMessage)
            }
        }), for: .touchUpInside)
    }
    
    func personalInfoVerifiedCheck() {
        joinupView.checkboxButton.addAction(UIAction(handler: { _ in
            self.isChecked = !self.isChecked
            if self.isChecked {
                let checkedImage = UIImage(named: "check")
                self.joinupView.checkboxButton.setImage(checkedImage, for: .normal)
            } else {
                let uncheckedImage = UIImage(named: "checkbox")
                self.joinupView.checkboxButton.setImage(uncheckedImage, for: .normal)
            }
        }), for: .touchUpInside)
    }
    
    // MARK: - SMTP 인증관련 코드
    
    func checkVerificationCode(completion: @escaping (Bool) -> Void) {
        guard let userInputCode = joinupView.smtpNumberTextField.text else {
            completion(false)
            return
        }
        
        if let savedCode = UserDefaults.standard.string(forKey: "emailVerificationCode"), savedCode == userInputCode {
            completion(true)
        } else {
            joinupView.smtpNumberButton.isEnabled = true
            joinupView.smtpNumberTextField.text = ""
            showAlert(message: "인증번호가 일치하지 않습니다.")
            
            // 인증에 실패한 경우 false를 반환
            completion(false)
        }
    }
    
    func verifyButtonPressed(_ sender: UIButton) {
        self.checkVerificationCode { _ in
            print("success")
        }
    }
    
    @objc func updateTimerLabel() {
        if seconds > 0 {
            seconds -= 1
//            self.isCheckedEmail = true
            joinupView.smtpTimerLabel.text = self.timeString(time: TimeInterval(seconds))
        } else if seconds == 0 {
            joinupView.smtpTimerLabel.isHidden = true
            self.joinupView.verifiedEmailButton.isEnabled = true
            self.joinupView.verifiedEmailButton.backgroundColor = .mainNavyColor
            self.joinupView.verifiedEmailButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
            self.joinupView.smtpTimerLabel.text = "대기중"
            self.isCheckedEmail = false
            seconds = 180
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
            let alert = UIAlertController(title: nil, message: "회원가입을\n취소하시겠습니까?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        carNumberView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carMakerView)
            self.carNumberView.isHidden = true
            self.carMakerView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        carMakerView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.carModelView)
            self.carMakerView.isHidden = true
            self.carModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        carModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.oilModelView)
            self.carModelView.isHidden = true
            self.oilModelView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        oilModelView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.nickNameView)
            self.oilModelView.isHidden = true
            self.nickNameView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        nickNameView.nextButton.addAction(UIAction(handler: { _ in
            self.view.addSubview(self.totalDistanceView)
            self.nickNameView.isHidden = true
            self.totalDistanceView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }), for: .touchUpInside)
        
        totalDistanceView.nextButton.addAction(UIAction(handler: { _ in
            let selectedOilType = self.oilModelView.selectedOil
            
            FirestoreService.firestoreService.saveCar(
                car: Car(
                    number: self.carNumberView.carNumberTextField.text,
                    maker: self.carMakerView.carMakerTextField.text,
                    name: self.carModelView.carModelTextField.text,
                    oilType: selectedOilType ?? "",
                    nickName: self.nickNameView.carNickNameTextField.text,
                    totalDistance: Int(self.totalDistanceView.totalDistanceTextField.text ?? "") ?? 0,
                    userEmail: self.joinupView.emailTextField.text),
                completion: { _ in
                    self.doneButtonTapped()
                })
        }), for: .touchUpInside)
    }
    
    func doneButtonTapped() {
        LoginService.loginService.keepLogin { user in
            if user != nil {
                let tabBarController = Util.mainTabBarController()
                if let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0 is UIWindowScene }) as? UIWindowScene,
                    let window = windowScene.windows.first
                {
                    window.rootViewController = tabBarController
                }
            }
        }
    }
}


