import UIKit

extension UILabel {
    func customLabel(text: String, textColor: UIColor, fontSize: CGFloat, alignment: NSTextAlignment){
        self.text = text
        self.font = UIFont(name: "Jua", size: fontSize)
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 2
    }
}

