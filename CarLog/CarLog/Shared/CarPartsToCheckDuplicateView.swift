//
//  CarPartsView.swift
//  CarLog
//
//  Created by 김은경 on 11/14/23.
//

import SnapKit
import UIKit

class CarPartsToCheckDuplicateView: UIView {
    let duplicateComponents = DuplicateComponents()

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua36, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = .spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold)
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height))
        textField.leftViewMode = .always
        textField.rightView = button
        textField.rightViewMode = .always
        return textField
    }()

    lazy var button: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .white
        configuration.imagePadding = 10

        let button = UIButton(configuration: configuration)
        button.customButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium), titleColor: .black, backgroundColor: .clear)
        return button
    }()

    lazy var nextButton = LargeButtonStackView(firstButtonText: "다 음", firstTitleColor: .buttonSkyBlueColor, firstBackgroudColor: .mainNavyColor, secondButtonText: "")

    private func setupUI() {
        let safeArea = safeAreaLayoutGuide

        addSubview(label)
        addSubview(textField)
        addSubview(nextButton)

        label.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top).offset(-150)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
        }

        textField.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(safeArea.snp.centerY).offset(-40)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }

        nextButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(75)
            make.centerX.equalTo(safeArea.snp.centerX)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
    }

    init(text: String, placeholder: String, buttonText: String) {
        super.init(frame: .zero)
        label.text = text
        textField.placeholder = placeholder
        nextButton.firstButton.setTitle(buttonText, for: .normal)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
