import UIKit

final class LoginPageProperties: UIView {
    lazy var logo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "로 그 인", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "email", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "password", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        return button
    }()
    
    lazy var loginStatusLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "로그인 상태 유지", textColor: .white, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var loginStatusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkboxButton, loginStatusLabel])
        stackView.customStackView(spacing: 10, axis: .horizontal, alignment: .center)
        return stackView
    }()
    
    lazy var leftDivider: UIView = {
        let divider = UIView()
        divider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.backgroundColor = .white
        return divider
    }()
    
    lazy var socialLoginDesignLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "SNS 계정으로 로그인", textColor: .white, font: Constants.fontJua16 ?? UIFont(), alignment: .center)
        return label
    }()
    
    lazy var rightDivider: UIView = {
        let divider = UIView()
        divider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.backgroundColor = .white
        return divider
    }()
    
    lazy var socialLoginDesignStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftDivider, socialLoginDesignLabel, rightDivider])
        stackView.customStackView(spacing: 2, axis: .horizontal, alignment: .center)
        return stackView
    }()
    
    lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "  Apple Login", font: Constants.fontJua24 ?? UIFont(), titleColor: .white, backgroundColor: .black)
        return button
    }()
    
    func setupUI() {
           let safeArea = self.safeAreaLayoutGuide
           addSubview(logo)
           addSubview(emailTextField)
           addSubview(passwordTextField)
           addSubview(loginStatusStackView)
           addSubview(loginButton)
           addSubview(socialLoginDesignStackView)
           addSubview(appleLoginButton)

           logo.snp.makeConstraints { make in
               make.top.equalTo(safeArea.snp.top).offset(10)
               make.leading.equalTo(safeArea.snp.leading).offset(85)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
           }

           emailTextField.snp.makeConstraints { make in
               make.top.equalTo(logo.snp.bottom).offset(10)
               make.leading.equalTo(safeArea.snp.leading).offset(10)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
           }

           passwordTextField.snp.makeConstraints { make in
               make.top.equalTo(emailTextField.snp.bottom).offset(10)
               make.leading.equalTo(safeArea.snp.leading).offset(10)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
           }

           loginStatusStackView.snp.makeConstraints { make in
               make.top.equalTo(passwordTextField.snp.bottom).offset(15)
               make.leading.equalTo(safeArea.snp.leading).offset(15)
           }

           loginButton.snp.makeConstraints { make in
               make.top.equalTo(passwordTextField.snp.bottom).offset(60)
               make.leading.equalTo(safeArea.snp.leading).offset(10)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
               make.width.equalTo(100)
               make.height.equalTo(50)
           }

           socialLoginDesignStackView.snp.makeConstraints { make in
               make.top.equalTo(loginButton.snp.bottom).offset(10)
               make.leading.equalTo(safeArea.snp.leading).offset(10)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
               make.width.equalTo(100)
               make.height.equalTo(50)
           }

           appleLoginButton.snp.makeConstraints { make in
               make.top.equalTo(socialLoginDesignStackView.snp.bottom).offset(10)
               make.leading.equalTo(safeArea.snp.leading).offset(10)
               make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
               make.width.equalTo(100)
               make.height.equalTo(50)
           }
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
