import UIKit

final class LoginView: UIView {
    lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var emailTextField = loginTextField(placeholder: "아이디 입력")
    lazy var passwordTextField = loginTextField(placeholder: "비밀번호 입력")
    lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: Constants.horizontalMargin).isActive = true
        button.heightAnchor.constraint(equalToConstant: Constants.horizontalMargin).isActive = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.backgroundColor = .white
        return button
    }()
    lazy var loginStatusLabel = basicLabel(text: "로그인 상태 유지")
    lazy var loginStatusStackView = loginStackView(list: [checkboxButton, loginStatusLabel], spacing: 5, alignment: .center)
    lazy var loginButton = loginButton(text: "로 그 인", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
    lazy var joinupButton = loginButton(text: "회원가입", font: Constants.fontJua16 ?? UIFont(), titleColor: .black, backgroundColor: .clear)
    lazy var spaceView = UIView()
    lazy var findIdPassword = loginButton(text: "아이디 · 비밀번호 찾기", font: Constants.fontJua16 ?? UIFont(), titleColor: .black, backgroundColor: .clear)
    lazy var signupStackView = loginStackView(list: [joinupButton, spaceView, findIdPassword], spacing: 0, alignment: .fill)
    lazy var leftDivider = divider()
    lazy var socialLoginDesignLabel = basicLabel(text: "SNS 계정으로 로그인")
    lazy var rightDivider = divider()
    lazy var socialLoginDesignStackView = loginStackView(list: [leftDivider, socialLoginDesignLabel, rightDivider], spacing: 2, alignment: .center)
    lazy var appleLoginButton: UIButton = loginButton(text: "  Apple Login", font: Constants.fontJua24 ?? UIFont(), titleColor: .white, backgroundColor: .black)
    
    private func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        addSubview(logo)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginStatusStackView)
        addSubview(loginButton)
        addSubview(signupStackView)
        addSubview(socialLoginDesignStackView)
        addSubview(appleLoginButton)

        logo.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        loginStatusStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(60)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
        
        signupStackView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        socialLoginDesignStackView.snp.makeConstraints { make in
            make.top.equalTo(signupStackView.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }

        appleLoginButton.snp.makeConstraints { make in
            make.top.equalTo(socialLoginDesignStackView.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
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
        label.customLabel(text: text, textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .center)
        return label
    }
    private func loginTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: placeholder, textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }
    private func loginButton(text: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: font, titleColor: titleColor, backgroundColor: backgroundColor)
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
