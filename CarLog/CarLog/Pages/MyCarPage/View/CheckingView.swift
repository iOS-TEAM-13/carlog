//
//  CheckEngineOilView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class CheckingView: UIView {
    private let CheckScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let checkTitle: UILabel = {
        let label = UILabel()
        label.customLabel(text: "타이틀", textColor: .primaryColor, font: Constants.fontJua36 ?? UIFont.systemFont(ofSize: 36), alignment: .center)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    lazy private var answerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, fifthAnswerButton])
        view.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        view.distribution = .fill
        return view
    }()
    
    lazy private var firstAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "첫번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .white, backgroundColor: .primaryColor)
        btn.tag = 1
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let secondAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "두번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .white, backgroundColor: .primaryColor)
        btn.tag = 2
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let thirdAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "세번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .white, backgroundColor: .primaryColor)
        btn.tag = 3
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let fourthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "네번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .white, backgroundColor: .primaryColor)
        btn.tag = 4
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let fifthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "다섯번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .white, backgroundColor: .primaryColor)
        btn.tag = 5
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    init(title: String, firstButton: String, secondButton: String, thirdbutton: String, fourthButton: String, fifthButton: String) {
        super.init(frame: .zero)
        setupUI()
        setupTitle(title: title)
        setupButton(firstButton: firstButton, secondButton: secondButton, thirdButton: thirdbutton, fourthButton: fourthButton, fifthbutton: fifthButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .thirdColor
        self.layer.cornerRadius = 20
        
        addSubview(checkTitle)
        addSubview(CheckScrollView)
        CheckScrollView.addSubview(answerStackView)
        
        checkTitle.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.verticalMargin)
            $0.height.equalTo(100)
        }
        
        CheckScrollView.snp.makeConstraints {
            $0.top.equalTo(checkTitle.snp.bottom).inset(Constants.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.horizontalMargin)
        }
        
        answerStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(CheckScrollView).inset(Constants.verticalMargin)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, fifthAnswerButton].forEach{ item in
            item.snp.makeConstraints {
                $0.height.equalTo(80)
            }
        }
    }
    
    private func setupTitle(title: String) {
        checkTitle.text = title
    }
    
    private func setupButton(firstButton: String, secondButton: String, thirdButton: String, fourthButton: String, fifthbutton: String) {
        firstAnswerButton.setTitle(firstButton, for: .normal)
        secondAnswerButton.setTitle(secondButton, for: .normal)
        thirdAnswerButton.setTitle(thirdButton, for: .normal)
        fourthAnswerButton.setTitle(fourthButton, for: .normal)
        fifthAnswerButton.setTitle(fifthbutton, for: .normal)
    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        firstAnswerButton.backgroundColor = .primaryColor
        secondAnswerButton.backgroundColor = .primaryColor
        thirdAnswerButton.backgroundColor = .primaryColor
        fourthAnswerButton.backgroundColor = .primaryColor
        fifthAnswerButton.backgroundColor = .primaryColor
        
        switch sender.tag {
        case 1: firstAnswerButton.backgroundColor = .secondColor
        case 2: secondAnswerButton.backgroundColor = .secondColor
        case 3: thirdAnswerButton.backgroundColor = .secondColor
        case 4: fourthAnswerButton.backgroundColor = .secondColor
        case 5: fifthAnswerButton.backgroundColor = .secondColor
        default:
            break
        }
    }
}
