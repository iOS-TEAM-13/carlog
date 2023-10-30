import UIKit

import SnapKit

final class JoinupView: UIView {
    let duplicateComponents = DuplicateComponents()
    var isSecure = true
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        return scrollView
    }()
        
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    lazy var emailLabel = makeLabel(text: "이메일", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)

    lazy var emailTextField: UITextField = {
        let textField = makeTextField(placeholder: "test@google.com")
        textField.rightView = checkEmailButton
        textField.delegate = self
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 18).isActive = true
        button.heightAnchor.constraint(equalToConstant: 18).isActive = true
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        return button
    }()
    
    lazy var personalInfoStatusLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "귀하는 카로그의 서비스 이용에 필요한 최소한의 개인정보 수집·이용에 동의하지 않을 수 있으나 동의를 거부할 경우 회원제 서비스 이용이 불가합니다.", textColor: .darkGray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .medium), alignment: .left)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var personalInfoStatusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkboxButton, personalInfoStatusLabel])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .horizontal, alignment: .center)
        return stackView
    }()

    
    @objc func closeKeyboard() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        smtpEmailTextField.resignFirstResponder()
        smtpNumberTextField.resignFirstResponder()
    }
    
    lazy var checkEmailButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium), titleColor: .black, backgroundColor: .clear)
        return button
    }()
    
    lazy var emailAlertLabel = makeAlertLabel(text: "이메일은 필수 입력 정보입니다", textColor: .red)
    
    lazy var passwordLabel = makeLabel(text: "비밀번호", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var passwordTextField: UITextField = {
        let textField = makeTextField(placeholder: "비밀번호", isSecure: isSecure)
        textField.isSecureTextEntry = isSecure
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 8글자 이상으로 작성하세요", textColor: .red)

    lazy var confirmPasswordLabel = makeLabel(text: "비밀번호 재확인", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = makeTextField(placeholder: "비밀번호 재확인", isSecure: isSecure)
        textField.isSecureTextEntry = isSecure
        textField.rightView = showConfirmPasswordButton
        textField.rightViewMode = .always
        textField.delegate = self
        return textField
    }()
    
    lazy var confirmPasswordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 8글자 이상으로 작성하세요", textColor: .red)
    
    lazy var smtpEmailLabel = makeLabel(text: "이메일 인증", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var smtpEmailTextField: UITextField = makeTextField(placeholder: "유효한 이메일을 입력", keyboardType: .emailAddress)
    
    lazy var smtpButton = makeButton(text: "인증", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
  
    lazy var smtpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpEmailTextField, smtpButton])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        stackView.distribution = .fillProportionally
        return stackView
    }()

    lazy var smtpNumberTextField: UITextField = makeTextField(placeholder: "인증번호", keyboardType: .numberPad)

    lazy var smtpNumberButton: UIButton = makeButton(text: "확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
    
    lazy var smtpTimerLabel: UILabel = makeLabel(text: "대기중", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
    
    lazy var smtpNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpNumberTextField, smtpNumberButton, smtpTimerLabel])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var allTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailAlertLabel, passwordLabel, passwordTextField, passwordAlertLabel, confirmPasswordLabel, confirmPasswordTextField, confirmPasswordAlertLabel, smtpEmailLabel, smtpStackView, smtpNumberStackView, personalInfoStatusStackView])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [joinInButton, popButton])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()

    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [allTextFieldStackView, buttonStackView])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var showPasswordButton: UIButton = makeToggleButton()
    lazy var showConfirmPasswordButton: UIButton = makeToggleButton()

    lazy var joinInButton = makeButton(text: "다 음", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold), titleColor: .gray, backgroundColor: .lightGray)
    lazy var popButton = makeButton(text: "취 소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold), titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
   
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(allStackView)
        
        smtpTimerLabel.isHidden = true
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
                    
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.height.equalTo(scrollView)
        }

        allStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }

        smtpNumberButton.snp.makeConstraints {
            $0.width.equalTo(smtpButton)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JoinupView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            smtpEmailTextField.becomeFirstResponder()
        } else if textField == smtpEmailTextField {
            smtpNumberTextField.becomeFirstResponder()
        }
        return true
    }
}

extension JoinupView {
    private func makeTextField(placeholder: String, isSecure: Bool = false, keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.loginCustomTextField(
            placeholder: placeholder,
            textColor: .black,
            font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            alignment: .left,
            paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)
            )
        )
        textField.isSecureTextEntry = isSecure
        textField.keyboardType = keyboardType
        textField.delegate = self
           
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
           
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        return textField
    }
    
    private func makeLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: textColor, font: font, alignment: alignment)
        return label
    }

    private func makeAlertLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: textColor, font: UIFont(name: "Jua", size: 12) ?? UIFont(), alignment: .left)
        label.isHidden = true
        return label
    }
    
    private func makeButton(text: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: font, titleColor: titleColor, backgroundColor: backgroundColor)
        button.layer.cornerRadius = Constants.cornerRadius
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }

    private func makeToggleButton() -> UIButton {
        var configuration = UIButton.Configuration.tinted()
        configuration.image = UIImage(named: "invisible")
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10

        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(named: "invisible"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return button
    }
    
    private func toggleVisibility(button: UIButton, textField: UITextField) {
        let imageName = isSecure ? "eye" : "invisible"
        button.setImage(UIImage(named: imageName), for: .normal)
        isSecure.toggle()
        textField.isSecureTextEntry = isSecure
    }
    
    @objc func togglePasswordVisibilityTapped() {
        toggleVisibility(button: showPasswordButton, textField: passwordTextField)
    }

    @objc func toggleConfirmVisibilityTapped() {
        toggleVisibility(button: showConfirmPasswordButton, textField: confirmPasswordTextField)
    }
}
