import UIKit

import SnapKit

class JoinupPageProperties: UIView {
    var isSecure = false
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "아이디", textColor: .white, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()

    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "아이디 입력", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
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
        label.customLabel(text: "비밀번호", textColor: .white, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호 입력", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
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
        label.customLabel(text: "비밀번호 재확인", textColor: .white, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: "비밀번호 재확인", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
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
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return button
    }()
    
    lazy var showConfirmPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .black
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return button
    }()
    
    lazy var joinInButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "회 원 가 입", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        return button
    }()
    
    func setupUI(){
        let safeArea = safeAreaLayoutGuide
        addSubview(emailStackView)
        addSubview(passwordStackView)
        addSubview(confirmPasswordStackView)
        addSubview(joinInButton)
        
        emailStackView.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(emailAlertLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        confirmPasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordAlertLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        joinInButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordAlertLabel.snp.bottom).offset(70)
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
