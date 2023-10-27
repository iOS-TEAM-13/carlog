import UIKit

extension UILabel {
    func customLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
}
