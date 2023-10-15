import UIKit

class DuplicateComponents {
    func joinupLabel(text: String) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: .black, font: Constants.fontJua36 ?? UIFont(), alignment: .left)
        label.numberOfLines = 2
        return label
    }
    
    func joinupTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: placeholder, textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }
    
    func popButton() -> UIButton {
        let button = UIButton()
        button.customButton(text: "이 전", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }

    func nextButton() -> UIButton {
        let button = UIButton()
        button.customButton(text: "다 음", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }
    
    func buttonStackView(list: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: list)
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .fill)
        return stackView
    }
}

