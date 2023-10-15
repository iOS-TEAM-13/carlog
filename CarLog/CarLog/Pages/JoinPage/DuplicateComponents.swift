import UIKit

class DuplicateComponents {
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

