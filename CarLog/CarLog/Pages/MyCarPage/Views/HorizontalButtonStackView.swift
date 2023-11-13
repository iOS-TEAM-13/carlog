//
//  HorizontalButtonStackView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class HorizontalButtonStackView: UIStackView {
    // MARK: Properties
    lazy var firstButton = UIButton()
    lazy var secondButton = UIButton()
    
    // MARK: LifeCycle
    init(firstButtonText: String, secondButtonText: String) {
        super.init(frame: .zero)
        firstButton.customButton(text: firstButtonText, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .white, backgroundColor: .mainNavyColor)
        secondButton.customButton(text: secondButtonText, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .white, backgroundColor: .mainNavyColor)
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
        self.customStackView(spacing: Constants.horizontalMargin * 2, axis: .horizontal, alignment: .fill)
        self.distribution = .fillEqually
        
        firstButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        secondButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
}
