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
}
