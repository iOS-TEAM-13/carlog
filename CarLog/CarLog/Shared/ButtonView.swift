//
//  ButtonView.swift
//  CarLog
//
//  Created by 김지훈 on 11/13/23.
//

import UIKit

func largeButton(text: String, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
    let button = UIButton()
    button.customButton(text: text, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: titleColor, backgroundColor: backgroundColor)
    button.layer.cornerRadius = Constants.cornerRadius
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return button
}
