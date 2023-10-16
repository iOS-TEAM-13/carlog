import UIKit

func DuplicateViews(text: String, placeholder: String) {
    lazy var label: UILabel = {
        let label = UILabel()
        label.customLabel(text: text, textColor: .white, font: Constants.fontJua36 ?? UIFont(), alignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var carNumberTextField: UITextField = {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: placeholder, textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var popButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "이 전", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .white)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }()
    
    lazy var spaceView = UIView()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [popButton, spaceView, nextButton])
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .fill)
        return stackView
    }()
}
