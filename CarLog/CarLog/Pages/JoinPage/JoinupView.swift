import UIKit

import SnapKit

final class JoinupView: UIView {
    let duplicateComponents = DuplicateComponents()
    var isSecure = true
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "아이디", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "아이디", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.rightView = checkEmailButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var checkEmailButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10
        
        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: Constants.fontJua14 ?? UIFont(), titleColor: .black, backgroundColor: .clear)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        return button
    }()
    
    lazy var emailAlertLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "영소문자와 숫자를 조합하여 6~12글자 이내로 작성하세요", textColor: .red, font: UIFont(name: "Jua", size: 12) ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var emailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailAlertLabel])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "비밀번호", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var passwordAlertLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 10~16글자 이내로 작성하세요", textColor: .red, font: UIFont(name: "Jua", size: 12) ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField, passwordAlertLabel])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()

    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "비밀번호 재확인", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호 재확인", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        textField.isSecureTextEntry = isSecure
        textField.rightView = showConfirmPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    lazy var confirmPasswordAlertLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "영대/소문자와 숫자, 특수문자를 조합하여 10~16글자 이내로 작성하세요", textColor: .red, font: UIFont(name: "Jua", size: 12) ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var confirmPasswordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextField, confirmPasswordAlertLabel])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
    lazy var showPasswordButton: UIButton = makeToggleButton()
    lazy var showConfirmPasswordButton: UIButton = makeToggleButton()
    lazy var joinInButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()

    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "취 소", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    // showPasswordButton, showConfirmPasswordButton 공통부분
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
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(emailStackView)
        addSubview(passwordStackView)
        addSubview(confirmPasswordStackView)
        addSubview(joinInButton)
        addSubview(popButton)
        
        showPasswordButton.addTarget(self, action: #selector(togglePasswordVisibilityTapped), for: .touchUpInside)
        showConfirmPasswordButton.addTarget(self, action: #selector(toggleConfirmVisibilityTapped), for: .touchUpInside)
        
        emailStackView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(emailAlertLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        confirmPasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordAlertLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        joinInButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordAlertLabel.snp.bottom).offset(30)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
        
        popButton.snp.makeConstraints { make in
            make.top.equalTo(joinInButton.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
    }
    
    @objc func togglePasswordVisibilityTapped() {
        toggleVisibility(button: showPasswordButton, textField: passwordTextField)
    }

    @objc func toggleConfirmVisibilityTapped() {
        toggleVisibility(button: showConfirmPasswordButton, textField: confirmPasswordTextField)
    }
    
    private func toggleVisibility(button: UIButton, textField: UITextField) {
        let imageName = isSecure ? "eye" : "invisible"
        button.setImage(UIImage(named: imageName), for: .normal)
        isSecure.toggle()
        textField.isSecureTextEntry = isSecure
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
