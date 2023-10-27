//
//  UIFont+.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/10/23.
//

import UIKit

extension UIFont {
    static func spoqaHanSansNeo(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName = "SpoqaHanSansNeo"

        var weightString: String
        switch weight {
        case .bold:
            weightString = "Bold"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        default:
            weightString = "Medium"
        }

        return UIFont(name: "\(fontName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}
