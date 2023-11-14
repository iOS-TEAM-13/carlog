//
//  LargeButtonView.swift
//  CarLog
//
//  Created by 김은경 on 11/14/23.
//

import SnapKit
import UIKit

class LargeButtonView: UIView {
//    weak var delegate: ButtonTappedViewDelegate?

    lazy var anyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.isSelected = true
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .bold)
        return button
    }()

    init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        anyButton.setTitle(title, for: .normal)
        anyButton.setTitleColor(titleColor, for: .selected)
        anyButton.backgroundColor = backgroundColor
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LargeButtonView {
    func setupUI() {
        setupButton()
    }

    func setupButton() {
        addSubview(anyButton)
        anyButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}

//extension LargeButtonView {
//    @objc func buttonTapped(_ button: UIButton) {
//        delegate?.didTapButton(button: button)
//    }
//}

