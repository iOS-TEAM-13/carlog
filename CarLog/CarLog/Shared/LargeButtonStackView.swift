//
//  LargeButtonStackView.swift
//  CarLog
//
//  Created by 김은경 on 11/14/23.
//

import UIKit

import SnapKit

class LargeButtonStackView: UIStackView {
    // MARK: Properties
    lazy var firstButton = UIButton()
    lazy var secondButton = UIButton()
    
    // MARK: LifeCycle
    init(firstButtonText: String, firstTitleColor: UIColor, firstBackgroudColor: UIColor, secondButtonText: String) {
        super.init(frame: .zero)
        secondButton.layer.cornerRadius = Constants.cornerRadius
        
        firstButton.myPageCustomButton(text: firstButtonText, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize24, weight: .bold), titleColor: firstTitleColor, backgroundColor: firstBackgroudColor)
        secondButton.myPageCustomButton(text: secondButtonText, font: UIFont.spoqaHanSansNeo(size: Constants.fontSize24, weight: .bold), titleColor: .white, backgroundColor: .mainNavyColor)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    // MARK: Method
    private func setupUI() {
        self.addArrangedSubview(firstButton)
        self.addArrangedSubview(secondButton)
        self.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        self.distribution = .fillEqually
        
        firstButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        secondButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
