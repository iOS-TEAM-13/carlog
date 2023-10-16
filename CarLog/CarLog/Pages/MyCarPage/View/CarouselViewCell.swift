//
//  CarouselCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class CarouselView: UIView {
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
        btn.customButton(text: "첫번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .black, backgroundColor: .thirdColor)
        btn.tag = 1
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let secondAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "두번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .black, backgroundColor: .thirdColor)
        btn.tag = 2
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let thirdAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "세번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .black, backgroundColor: .thirdColor)
        btn.tag = 3
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let fourthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "네번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .black, backgroundColor: .thirdColor)
        btn.tag = 4
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let fifthAnswerButton: UIButton = {
        let btn = UIButton()
        btn.customButton(text: "다섯번째", font: Constants.fontJua24 ?? UIFont.systemFont(ofSize: 24), titleColor: .black, backgroundColor: .thirdColor)
        btn.tag = 5
        btn.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    static let identifier = "CarouselViewCell"
    
    private lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    init(view: CheckingView) {
        super.init(frame: .zero)
        self.checkTitle.text = view.title
        self.firstAnswerButton.setTitle(view.firstButton, for: .normal)
        self.secondAnswerButton.setTitle(view.secondButton, for: .normal)
        self.thirdAnswerButton.setTitle(view.thirdbutton, for: .normal)
        self.fourthAnswerButton.setTitle(view.fourthButton, for: .normal)
        self.fifthAnswerButton.setTitle(view.fifthButton, for: .normal)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //        contentView.backgroundColor = .thirdColor
        //        contentView.layer.cornerRadius = 20
        self.addSubview(customView)
        
        customView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            //            $0.center.equalToSuperview()
            //            $0.width.equalTo(300)
            //            $0.height.equalTo(600)
        }
        
        
        
        customView.addSubview(checkTitle)
        customView.addSubview(CheckScrollView)
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
    
    func bind(checkingView: CheckingView) {
        //           addSubview(customView)
        //           customView = view
        //           view.snp.makeConstraints {
        //               $0.width.equalTo(300)
        //               $0.height.equalTo(600)
        //           }
        
        checkTitle.text = checkingView.title
        firstAnswerButton.setTitle(checkingView.firstButton, for: .normal)
        secondAnswerButton.setTitle(checkingView.secondButton, for: .normal)
        thirdAnswerButton.setTitle(checkingView.thirdbutton, for: .normal)
        fourthAnswerButton.setTitle(checkingView.fourthButton, for: .normal)
        fifthAnswerButton.setTitle(checkingView.fifthButton, for: .normal)
    }
    
    //    private func setupTitle(title: String) {
    //        checkTitle.text = title
    //    }
    //
    //    private func setupButton(firstButton: String, secondButton: String, thirdButton: String, fourthButton: String, fifthbutton: String) {
    //        firstAnswerButton.setTitle(firstButton, for: .normal)
    //        secondAnswerButton.setTitle(secondButton, for: .normal)
    //        thirdAnswerButton.setTitle(thirdButton, for: .normal)
    //        fourthAnswerButton.setTitle(fourthButton, for: .normal)
    //        fifthAnswerButton.setTitle(fifthbutton, for: .normal)
    //    }
    
    @objc func checkButtonTapped(sender: UIButton) {
        let temp = [firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourthAnswerButton, fifthAnswerButton]
        temp.forEach { item in
            item.backgroundColor = .thirdColor
            item.setTitleColor(.black, for: .normal)
        }
        
        switch sender.tag {
        case 1:
            firstAnswerButton.backgroundColor = .primaryColor
            firstAnswerButton.setTitleColor(.white, for: .normal)
        case 2:
            secondAnswerButton.backgroundColor = .primaryColor
            secondAnswerButton.setTitleColor(.white, for: .normal)
        case 3:
            thirdAnswerButton.backgroundColor = .primaryColor
            thirdAnswerButton.setTitleColor(.white, for: .normal)
        case 4:
            fourthAnswerButton.backgroundColor = .primaryColor
            fourthAnswerButton.setTitleColor(.white, for: .normal)
        case 5:
            fifthAnswerButton.backgroundColor = .primaryColor
            fifthAnswerButton.setTitleColor(.white, for: .normal)
        default:
            break
        }
    }
}

//class CarouselViewCell: UICollectionViewCell {
//    static let identifier = "CarouselViewCell"
//    
//    private lazy var customView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .primaryColor
//        view.layer.cornerRadius = 20
//        view.clipsToBounds = true
//        return view
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupUI()
//    }
//    
//    func bind(view: UIView) {
//        addSubview(customView)
//        customView = view
//        view.snp.makeConstraints {
//            $0.width.equalTo(300)
//            $0.height.equalTo(600)
//        }
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(customView)
//        
//        customView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.equalTo(300)
//            $0.height.equalTo(600)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

