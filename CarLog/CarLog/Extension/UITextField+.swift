import UIKit

extension UITextField {
    func customTextField(placeholder: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment){
        self.placeholder = placeholder
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
    
    func loginCustomTextField(placeholder: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment, paddingView: UIView){
        self.placeholder = placeholder
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = Constants.cornerRadius
        self.backgroundColor = .white
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func mypageCustomTextField(placeholder: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment){
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.systemGray.cgColor
        border.frame = CGRect(x: 0, y: 45, width: UIScreen.main.bounds.width - 40, height: 1)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.placeholder = placeholder
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.leftViewMode = .always
    }
    
    func historyCustomTextField(placeholder: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment, paddingView: UIView){
        self.placeholder = placeholder
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 15
        self.backgroundColor = .white
        self.rightView = paddingView
        self.rightViewMode = .always
    }
     

}
