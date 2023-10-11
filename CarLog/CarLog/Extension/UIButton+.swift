import UIKit

extension UIButton {
    func customButton(text: String, fontSize: CGFloat,titleColor: UIColor, backgroundColor: UIColor){
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont(name: "Jua", size: fontSize)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 7
    }
}
