import UIKit

import AuthenticationServices

final class LoginView: UIView {

    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = "CARLOG"
        label.textColor = .mainNavyColor
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua40, weight: .black)
        return label
    }()

    lazy var emailTextField = loginTextField(placeholder: "이메일")
    lazy var passwordTextField = loginTextField(placeholder: "비밀번호")

    lazy var loginButton = largeButton(text: "로 그 인", titleColor: .gray, backgroundColor: .lightGray)
    lazy var joinupButton = loginButton(text: "회원가입", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .black, backgroundColor: .clear)
    lazy var spaceView = UIView()
    lazy var findIdPassword = loginButton(text: "아이디 · 비밀번호 찾기", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .black, backgroundColor: .clear)
    lazy var signupStackView = loginStackView(list: [joinupButton, spaceView, findIdPassword], spacing: 0, alignment: .fill)

    lazy var leftDivider = divider()

    private func setupUI() {
        let safeArea = safeAreaLayoutGuide

        addSubview(logoLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(signupStackView)

        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(Constants.verticalMargin * 12)
            make.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { make in
             make.top.equalTo(logoLabel.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            //make.height.equalTo(50)
        }

        signupStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(Constants.verticalMargin)
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

    private func basicLabel(text: String) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return label
    }

    private func loginTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: placeholder, textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }

    private func loginButton(text: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: font, titleColor: titleColor, backgroundColor: backgroundColor)
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }

    private func divider() -> UIView {
        let divider = UIView()
        divider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.backgroundColor = .black
        return divider
    }

    private func loginStackView(list: [UIView], spacing: CGFloat, alignment: UIStackView.Alignment) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: list)
        stackView.customStackView(spacing: spacing, axis: .horizontal, alignment: alignment)
        return stackView
    }
}
