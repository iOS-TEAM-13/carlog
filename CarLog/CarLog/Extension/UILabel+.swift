import UIKit

extension UILabel {
    func customLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.sizeToFit()
        self.textAlignment = alignment
        self.textColor = textColor
    }
    
    //재사용 km단위 라벨 추가
    static func kmUnitLabel() -> UILabel {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium), alignment: .left)
        return kmLabel
    }
    
    //재사용 원단위 라벨 추가
    static func wonUnitLabel() -> UILabel {
        let wonUnitLabel = UILabel()
        wonUnitLabel.customLabel(text: "원", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium), alignment: .left)
        return wonUnitLabel
    }
    
    //재사용 L단위 라벨 추가
    static func literUnitLabel() -> UILabel {
        let literUnitLabel = UILabel()
        literUnitLabel.customLabel(text: "L", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize20, weight: .medium), alignment: .left)
        return literUnitLabel
    }
    
}
