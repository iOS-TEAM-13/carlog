//
//  MyPageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/10/13.
//

import UIKit
import SnapKit

final class MyPageView: UIView {
    
    // MARK: -
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 차 정보"
        label.textColor = .black
        label.font = Constants.fontJua28
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: -
    
    //텍스트 폰트에 따른 언더라인 수정
    lazy var myWritingButton: UIButton = {
        let myWritingButton = UIButton()
        myWritingButton.customButton(text: "내가 작성한 글", font: Constants.fontJua20 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        return myWritingButton     // ⭐ 나중에 Community Page 연결 필요
    }()
    
    lazy var textField1: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "차량 번호 ex)56머3344", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return textField
    }()
    
    lazy var textField2: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "차 종류", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return textField
    }()
    
    lazy var textField3: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "제조사", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return textField
    }()
    
    lazy var textField4: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "연료 종류", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .left)
        return textField
    }()
    
    lazy var logoutButton: UIButton = {
        let logoutbutton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.fontJua16 ?? UIFont(),
            .foregroundColor: UIColor.lightGray]
//            .underlineStyle: NSUnderlineStyle.single.rawValue] // 글씨 언더라인 메서드
        let attributedTitle = NSAttributedString(string: "로그아웃", attributes: attributes)
        logoutbutton.setAttributedTitle(attributedTitle, for: .normal)
        logoutbutton.backgroundColor = .clear
        return logoutbutton
    }()
    
    lazy var horizontalDivider: UIView = {
        let horizontaldivider = UIView()
        horizontaldivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        horizontaldivider.heightAnchor.constraint(equalToConstant: 16).isActive = true
        horizontaldivider.backgroundColor = .lightGray
        return horizontaldivider
    }()
    
    lazy var membershipWithdrawalButton: UIButton = {
        let membershipwithdrawalbutton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.fontJua16 ?? UIFont(),
            .foregroundColor: UIColor.lightGray]
//            .underlineStyle: NSUnderlineStyle.single.rawValue] // 글씨 언더라인 메서드
        let attributedTitle = NSAttributedString(string: "회원탈퇴", attributes: attributes)
        membershipwithdrawalbutton.setAttributedTitle(attributedTitle, for: .normal)
        membershipwithdrawalbutton.backgroundColor = .clear
        return membershipwithdrawalbutton
    }()
    
    lazy var myPageDesignStackView = {
        let mypagedesignstackview = UIStackView(arrangedSubviews: [logoutButton, horizontalDivider, membershipWithdrawalButton])
        mypagedesignstackview.customStackView(spacing: 5, axis: .horizontal , alignment: .center)
        mypagedesignstackview.distribution = .equalSpacing
        return mypagedesignstackview
    }()
    
    lazy var phoneCallButton: UIButton = {
        let phoneCallbutton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .primaryColor
        config.cornerStyle = .capsule
        config.image = UIImage(named: "Context Icon")
        phoneCallbutton.configuration = config
        phoneCallbutton.layer.shadowOffset = CGSize(width: 5, height: 5)
        phoneCallbutton.layer.shadowRadius = 10
        phoneCallbutton.layer.shadowOpacity = 0.3
        return phoneCallbutton
    }()
    
    // MARK: -
    
    func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(titleLabel)
        addSubview(editButton)
        addSubview(myWritingButton)
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        addSubview(myPageDesignStackView)
        addSubview(phoneCallButton)
        
        textField1.isUserInteractionEnabled = false
        textField2.isUserInteractionEnabled = false
        textField3.isUserInteractionEnabled = false
        textField4.isUserInteractionEnabled = false
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Constants.verticalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(Constants.horizontalMargin * 20)
            make.leading.equalTo(safeArea.snp.leading).offset(-Constants.horizontalMargin)
        }
        
        myWritingButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalMargin * 2.5)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
        
        textField1.snp.makeConstraints { make in
            make.top.equalTo(myWritingButton.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        textField2.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        textField3.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        textField4.snp.makeConstraints { make in
            make.top.equalTo(textField3.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        myPageDesignStackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).offset(-Constants.verticalMargin * 2)
            make.leading.equalTo(safeArea.snp.leading).offset(UIScreen.main.bounds.width * 0.3)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-UIScreen.main.bounds.width * 0.3)
        }
        
        phoneCallButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-110)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 55, height: 55))
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
