import UIKit

import FirebaseAuth
import SwiftSMTP

// MARK: - 회원가입의 주요 기능 구현 코드 (addActions)

extension JoinupPageViewController {
    // textField Events
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
    
    // MARK: 텍스트 필드 변경 관련

    private func textFieldDidChange() {
        let isEmailValid = joinupView.emailTextField.text?.isValidEmail() ?? false
        let isPasswordValid = joinupView.passwordTextField.text?.isValidPassword() ?? false
        let isConfirmPassword = joinupView.confirmPasswordTextField.text?.isValidPassword() ?? false
        let isSMTPNumber = joinupView.smtpNumberTextField.text?.count == 6

        UIView.animate(withDuration: 0.3) {
            if isEmailValid, isPasswordValid, isConfirmPassword, isSMTPNumber {
                self.joinupView.buttonStackView.firstButton.isEnabled = true
                self.joinupView.buttonStackView.firstButton.setTitleColor(.buttonSkyBlueColor, for: .normal)
                self.joinupView.buttonStackView.firstButton.backgroundColor = .mainNavyColor
            } else {
                self.joinupView.buttonStackView.firstButton.isEnabled = false
                self.joinupView.buttonStackView.firstButton.setTitleColor(.gray, for: .normal) // 비활성화 시 글자 색 변경
                self.joinupView.buttonStackView.firstButton.backgroundColor = .lightGray // 비활성화 시 배경색 변경
            }
        }
    }
    
    // 아이디 중복체크 코드
    func addCheckEmailButtonAction() {
        joinupView.emailTextField.addAction(UIAction(handler: { _ in
            self.joinupView.checkEmailButton.setTitleColor(.black, for: .normal)
            self.joinupView.checkEmailButton.setTitle("중복확인", for: .normal)
        }), for: .editingChanged)
        
        joinupView.checkEmailButton.addAction(UIAction(handler: { _ in
            guard let emailToCheck = self.joinupView.emailTextField.text, !emailToCheck.isEmpty, emailToCheck.isValidEmail() else {
                return self.showAlert(message: "올바른 이메일 형식이 아닙니다", completion: {})
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
                    self.joinupView.emailTextField.text = ""
                }
            }
        }), for: .touchUpInside)
    }
    
    // 차 번호 중복검사 버튼
    func checkCarNumberButtonAction() {
        carNumberView.textField.addAction(UIAction(handler: { _ in
            self.carNumberView.button.setTitleColor(.black, for: .normal)
            self.carNumberView.button.setTitle("중복확인", for: .normal)
        }), for: .editingChanged)
        
        carNumberView.button.addAction(UIAction(handler: { _ in
            guard let carNumberToCheck = self.carNumberView.textField.text, !carNumberToCheck.isEmpty else {
                return self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
            }
            
            guard carNumberToCheck.isValidateCarNumber(carNumberToCheck) else {
                return self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
            }
            
            guard carNumberToCheck.count >= 7 else {
                return self.showAlert(message: "7자리 이상 입력하세요", completion: {})
            }
            
            let fifthCharacterIndex = carNumberToCheck.index(carNumberToCheck.endIndex, offsetBy: -5)
            let fifthCharacter = carNumberToCheck[fifthCharacterIndex]

            if String(fifthCharacter).range(of: "[가-힣]+", options: .regularExpression) == nil {
                return self.showAlert(message: "00가0000 형식으로 써주세요", completion: {})
            }
            
            FirestoreService.firestoreService.checkDuplicate(car: carNumberToCheck, data: "number", completion: { isCarAvailable, error in
                if let error = error {
                    print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                    return
                }
                
                if isCarAvailable {
                    self.carNumberView.button.setTitleColor(.mainNavyColor, for: .normal)
                    self.carNumberView.button.setTitle("가능", for: .normal)
                } else {
                    self.carNumberView.button.setTitleColor(.red, for: .normal)
                    self.carNumberView.button.setTitle("불가능", for: .normal)
                    self.showAlert(message: "이미 존재하는 차번호입니다", completion: {})
                    self.carNumberView.textField.text = ""
                }
            })
        }), for: .touchUpInside)
    }
    
    func CheckNickNameButtonAction() {
        nickNameView.textField.addAction(UIAction(handler: { _ in
            self.nickNameView.button.setTitleColor(.black, for: .normal)
            self.nickNameView.button.setTitle("중복확인", for: .normal)
        }), for: .editingChanged)
        
        nickNameView.button.addAction(UIAction(handler: { _ in
            guard let nickNameToCheck = self.nickNameView.textField.text, !nickNameToCheck.isEmpty else { return }
            
            FirestoreService.firestoreService.checkDuplicate(car: nickNameToCheck, data: "nickName", completion: { isCarAvailable, error in
                if let error = error {
                    print("Firestore에서 사용자 목록을 가져오는데 실패했습니다: \(error.localizedDescription)")
                    return
                }
                
                if isCarAvailable {
                    self.nickNameView.button.setTitleColor(.mainNavyColor, for: .normal)
                    self.nickNameView.button.setTitle("가능", for: .normal)
                } else {
                    self.nickNameView.button.setTitleColor(.red, for: .normal)
                    self.nickNameView.button.setTitle("불가능", for: .normal)
                    self.showAlert(message: "이미 존재하는 닉네임입니다", completion: {})
                    self.nickNameView.textField.text = ""
                }
            })
        }), for: .touchUpInside)
    }
    
    // SMTP 인증버튼 코드
    func addSMTPButtonAction() {
        joinupView.verifiedEmailButton.addAction(UIAction(handler: { _ in
            guard let emailText = self.joinupView.emailTextField.text,
                  !emailText.isEmpty,
                  emailText.isValidEmail()
            else {
                self.showAlert(message: "유효하지 않는 이메일 형식이거나 이메일이 비어 있습니다", completion: {})
                return
            }
            
            // smtp 로직
            let smtp = SMTP(hostname: "smtp.gmail.com", email: "carlog2313@gmail.com", password: "jucyydwmjblsyamf")
            
            let from = Mail.User(name: "CarLog", email: "carlog2313@gmail.com")
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
            
            self.seconds = 180
            self.startTimer()
        }), for: .touchUpInside)
    }

    // SMTP 인증번호 코드
    func addSMTPNumberButtonAction() {
        joinupView.smtpNumberButton.addAction(UIAction(handler: { _ in
            self.checkVerificationCode { success in
                if success {
                    self.showAlert(message: "인증이 성공적으로 처리되었습니다", completion: {})
                    self.joinupView.smtpTimerLabel.isHidden = true
                    self.stopTimer()
                    self.joinupView.smtpNumberButton.setTitle("완료", for: .normal)
                    self.joinupView.verifiedEmailButton.isEnabled = false
                    self.joinupView.verifiedEmailButton.setTitleColor(.gray, for: .normal)
                    self.joinupView.verifiedEmailButton.backgroundColor = .lightGray
                }
            }
        }), for: .touchUpInside)
    }
    
    // 회원가입 "다음" 버튼 코드
    func addJoinInButtonAction() {
        joinupView.buttonStackView.firstButton.addAction(UIAction(handler: { _ in
            if self.joinupView.checkEmailButton.title(for: .normal) != "가능" {
                self.showAlert(message: "아이디 중복검사를 해주세요", completion: {})
                return
            }
            
            if self.joinupView.smtpNumberButton.title(for: .normal) != "완료" {
                self.showAlert(message: "인증번호를 확인해주세요", completion: {})
            }
            
            guard let email = self.joinupView.emailTextField.text,
                  let password = self.joinupView.passwordTextField.text,
                  let confirmPassword = self.joinupView.confirmPasswordTextField.text,
                  let smtpNumber = self.joinupView.smtpNumberTextField.text
            else {
                return
            }
            
            let isEmailValid = email.isValidEmail()
            let isPasswordValid = password.isValidPassword()
            let isConfirmPasswordValid = confirmPassword == password
            let isSMTPNumber = smtpNumber.count == 6
            let personalInfoCheck = self.joinupView.checkboxButton.isSelected == !self.isChecked
            
            if isEmailValid, isPasswordValid, isConfirmPasswordValid, isSMTPNumber, personalInfoCheck {
                self.checkVerificationCode { success in
                    if success {
                        self.view.addSubview(self.carNumberView)
                        self.joinupView.isHidden = true
                        self.carNumberView.isHidden = false
                        self.carNumberView.snp.makeConstraints { make in
                            make.edges.equalToSuperview()
                        }
                    } else {
                        if self.joinupView.smtpNumberTextField.text?.count == 6 {
                            self.joinupView.smtpNumberTextField.text = "" // 6자리이고 일치하지 않으면 입력값 초기화
                            self.showAlert(message: "인증번호가 일치하지 않습니다", completion: {})
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
                self.showAlert(message: alertMessage, completion: {})
            }
        }), for: .touchUpInside)
    }
    
    // 개인정보 동의 체크버튼 코드
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
    
    private func checkVerificationCode(completion: @escaping (Bool) -> Void) {
        guard let userInputCode = joinupView.smtpNumberTextField.text else {
            completion(false)
            return
        }
        
        if let savedCode = UserDefaults.standard.string(forKey: "emailVerificationCode"), savedCode == userInputCode {
            completion(true)
        } else {
            joinupView.smtpNumberButton.isEnabled = true
            joinupView.smtpNumberTextField.text = ""
            showAlert(message: "인증번호가 일치하지 않습니다.", completion: {})
            
            // 인증에 실패한 경우 false를 반환
            completion(false)
        }
    }
    
    private func verifyButtonPressed(_ sender: UIButton) {
        self.checkVerificationCode { _ in
            print("success")
        }
    }
}
