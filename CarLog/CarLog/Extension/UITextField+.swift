import UIKit

extension UITextField {
    func customTextField(placeholder: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment){
        self.placeholder = placeholder
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
}
