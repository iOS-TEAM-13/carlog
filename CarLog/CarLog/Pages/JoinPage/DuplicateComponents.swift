import UIKit

class DuplicateComponents {
    func joinupLabel(text: String) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua36, weight: .medium), alignment: .left)
        label.numberOfLines = 2
        return label
    }

    func joinupTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.loginCustomTextField(placeholder: placeholder, textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }

    func joininButton(text: String) -> UIButton {
        let button = UIButton()
        button.customButton(text: text, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .primaryColor, backgroundColor: .thirdColor)
        button.layer.cornerRadius = Constants.cornerRadius
        button.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return button
    }

    func buttonStackView(list: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: list)
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .fill)
        return stackView
    }
}
