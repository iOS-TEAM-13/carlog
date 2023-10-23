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
        button.setImage(UIImage(systemName: "pencil.line"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    // MARK: -
    
    //텍스트 폰트에 따른 언더라인 수정
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
    
    // ⭐ 나중에 Community Page 연결 필요
    lazy var myWritingButton: UIButton = {
        let myWritingButton = UIButton()
        myWritingButton.customButton(text: "내가 작성한 글", font: Constants.fontJua20 ?? UIFont(), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
        return myWritingButton
    }()
    
    lazy var logoutButton: UIButton = {
        let logoutbutton = UIButton()
        logoutbutton.customButton(text: "로그아웃", font: Constants.fontJua20 ?? UIFont(), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
        return logoutbutton
    }()
    
    lazy var membershipWithdrawalButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Constants.fontJua16 ?? UIFont(),
            .foregroundColor: UIColor.lightGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedTitle = NSAttributedString(string: "회원 탈퇴", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var floatingButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.cornerStyle = .capsule
        config.image = UIImage(named: "Context Icon")
        button.configuration = config
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        //            button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: -
    
    func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(titleLabel)
        addSubview(editButton)
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        addSubview(myWritingButton)
        addSubview(logoutButton)
        addSubview(membershipWithdrawalButton)
        addSubview(floatingButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        textField1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalMargin * 2)
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
        
        myWritingButton.snp.makeConstraints { make in
            make.top.equalTo(textField4.snp.bottom).offset(150)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(myWritingButton.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        membershipWithdrawalButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(safeArea.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        floatingButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-120)
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
