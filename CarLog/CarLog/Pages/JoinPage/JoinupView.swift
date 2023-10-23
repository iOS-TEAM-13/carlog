import UIKit

import SnapKit

final class JoinupView: UIView {
    let duplicateComponents = DuplicateComponents()
    var isSecure = true
    
    lazy var emailLabel = makeLabel(text: "아이디", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "아이디", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.rightView = checkEmailButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var checkEmailButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium), titleColor: .black, backgroundColor: .clear)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        return button
    }()
    
    lazy var emailAlertLabel = makeAlertLabel(text: "아이디는 필수 입력 정보입니다", textColor: .red)
    
    lazy var passwordLabel = makeLabel(text: "비밀번호", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var passwordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 10~16글자 이내로 작성하세요", textColor: .red)

    lazy var confirmPasswordLabel = makeLabel(text: "비밀번호 재확인", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호 재확인", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showConfirmPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var confirmPasswordAlertLabel = makeAlertLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 10~16글자 이내로 작성하세요", textColor: .red)
    
    lazy var smtpEmailLabel = makeLabel(text: "이메일 인증", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
    
    lazy var smtpEmailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "유효한 이메일을 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var smtpButton = makeButton(text: "인증", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .primaryColor, backgroundColor: .thirdColor)
    lazy var stmpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpEmailTextField, smtpButton])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        smtpEmailTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.75).isActive = true
        smtpButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        return stackView
    }()
    
    lazy var smtpNumberTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "인증번호를 입력", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var smtpNumberButton: UIButton = makeButton(text: "확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .primaryColor, backgroundColor: .thirdColor)
    
    lazy var smtpTimerLabel: UILabel = makeLabel(text: "3:00", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
    
    lazy var smtpNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smtpNumberTextField, smtpNumberButton, smtpTimerLabel])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        smtpNumberTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5).isActive = true
        smtpNumberButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2).isActive = true
        return stackView
    }()
    
    lazy var allTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailAlertLabel, passwordLabel, passwordTextField, passwordAlertLabel, confirmPasswordLabel, confirmPasswordTextField, confirmPasswordAlertLabel, smtpEmailLabel, stmpStackView, smtpNumberStackView])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [joinInButton, popButton])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var showPasswordButton: UIButton = makeToggleButton()
    lazy var showConfirmPasswordButton: UIButton = makeToggleButton()
    lazy var joinInButton = makeButton(text: "다 음", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .primaryColor, backgroundColor: .thirdColor)
    lazy var popButton = makeButton(text: "취 소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .primaryColor, backgroundColor: .thirdColor)
   
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(allTextFieldStackView)
        addSubview(buttonStackView)
        
        smtpTimerLabel.isHidden = true
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
        
        allTextFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(Constants.verticalMargin * 5)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.snp.bottom).offset(-Constants.verticalMargin * 2)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
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

extension JoinupView {
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
