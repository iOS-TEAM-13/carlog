import UIKit

extension UIButton {
    func customButton(text: String, font: UIFont, titleColor: UIColor, backgroundColor: UIColor) {
        self.setTitleColor(titleColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = 15
    }
    
    func checkingViewButton(text: String, tag: Int) {
        self.setTitleColor(.black, for: .normal)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        self.backgroundColor = .buttonSkyBlueColor
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
        self.layer.cornerRadius = Constants.cornerRadius * 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 1
        self.tag = tag
    }
}
