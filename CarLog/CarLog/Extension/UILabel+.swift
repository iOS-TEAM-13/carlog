import UIKit

extension UILabel {
    func customLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
    
    //재사용 단위 라벨 추가
    static func kmUnitLabel() -> UILabel {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .left)
        return kmLabel
    }
    
}
