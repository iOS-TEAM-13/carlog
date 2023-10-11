import UIKit

extension UITextField {
    func customTextField(placeholder: String, textColor: UIColor, fontSize: CGFloat, alignment: NSTextAlignment){
        self.placeholder = placeholder
        self.font = UIFont(name: "Jua", size: fontSize)
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
}
