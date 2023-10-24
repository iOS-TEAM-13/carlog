//
//  CarouselCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class ComponentsView: UIView {
    private let CheckScrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let checkTitleLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "타이틀", textColor: .mainNavyColor, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua36, weight: .bold), alignment: .center)
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
    
    let firstAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "첫번째", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .black, backgroundColor: .buttonSkyBlueColor)
        btn.tag = 1
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 4
        return btn
    }()
    
     let secondAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "두번째", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .black, backgroundColor: .buttonSkyBlueColor)
        btn.tag = 2
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 4
        return btn
    }()
    
     let thirdAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "세번째", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .black, backgroundColor: .buttonSkyBlueColor)
        btn.tag = 3
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 4
        return btn
    }()
  
     let fourthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "네번째", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .black, backgroundColor: .buttonSkyBlueColor)
        btn.tag = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 4
        return btn
    }()
    
     let fifthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "다섯번째", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .black, backgroundColor: .buttonSkyBlueColor)
        btn.tag = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.4
        btn.layer.shadowOffset = CGSize(width: 0, height: 4)
        btn.layer.shadowRadius = 4
        return btn
    }()
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    init(view: CheckingView) {
        super.init(frame: .zero)
        setupUI()
        configureUI(view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        customView.addSubview(checkTitleLabel)
        customView.addSubview(CheckScrollView)
        CheckScrollView.addSubview(answerStackView)
        
        checkTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Constants.verticalMargin)
            $0.height.equalTo(100)
        }
        
        CheckScrollView.snp.makeConstraints {
            $0.top.equalTo(checkTitleLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.bottom.equalToSuperview().inset(Constants.horizontalMargin)
        }
        
        answerStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(CheckScrollView).inset(Constants.verticalMargin)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, fifthAnswerButton].forEach { item in
            item.snp.makeConstraints {
                $0.height.equalTo(80)
            }
        }
    }
    
    private func configureUI(view: CheckingView) {
        self.checkTitleLabel.text = view.title
        self.firstAnswerButton.setTitle(view.firstButton, for: .normal)
        self.secondAnswerButton.setTitle(view.secondButton, for: .normal)
        self.thirdAnswerButton.setTitle(view.thirdbutton, for: .normal)
        self.fourthAnswerButton.setTitle(view.fourthButton, for: .normal)
        self.fifthAnswerButton.setTitle(view.fifthButton, for: .normal)
    }
    
    func bind(checkingView: CheckingView) {
        checkTitleLabel.text = checkingView.title
        firstAnswerButton.setTitle(checkingView.firstButton, for: .normal)
        secondAnswerButton.setTitle(checkingView.secondButton, for: .normal)
        thirdAnswerButton.setTitle(checkingView.thirdbutton, for: .normal)
        fourthAnswerButton.setTitle(checkingView.fourthButton, for: .normal)
        fifthAnswerButton.setTitle(checkingView.fifthButton, for: .normal)
    }
}
