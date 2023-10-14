//
//  MyPageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/10/13.
//

import UIKit

final class MyPageView: UIView {
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "내 차 정보"
       label.font = UIFont(name: "Jua", size: 45)
       return label
    }()
    
    lazy var textField1: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "차량 번호 ex)56머3344", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var textField2: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "차 종류", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var textField3: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "제조사", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var textField4: UITextField = {
        let textField = UITextField()
        textField.mypageCustomTextField(placeholder: "연료 종류", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
        return textField
    }()
    
    lazy var spaceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var leftDivider: UIView = {
        let divider = UIView()
        divider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.backgroundColor = .black
        return divider
    }()
    
    lazy var myPageDesignLabel: UILabel = {
        let label = UILabel()
        label.customLabel(text: "정비소와 연락하기", textColor: .black, font: Constants.fontJua16 ?? UIFont(), alignment: .center)
        return label
    }()
    
    lazy var rightDivider: UIView = {
        let divider = UIView()
        divider.widthAnchor.constraint(equalToConstant: 100).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider.backgroundColor = .black
        return divider
    }()
    
    lazy var myPageDesignStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftDivider, myPageDesignLabel, rightDivider])
        stackView.customStackView(spacing: 2, axis: .horizontal, alignment: .center)
        return stackView
    }()
    
    lazy var automechanicButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "정비소와 연락하기", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        return button
    }()
    
    func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(titleLabel)
        addSubview(textField1)
        addSubview(textField2)
        addSubview(textField3)
        addSubview(textField4)
        addSubview(myPageDesignStackView)
        addSubview(automechanicButton)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(10)
            make.left.equalTo(safeArea.snp.left).offset(20)
           
        }

        textField1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        textField2.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }
        
        textField3.snp.makeConstraints { make in
            make.top.equalTo(textField2.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        textField4.snp.makeConstraints { make in
            make.top.equalTo(textField3.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
        }

        myPageDesignStackView.snp.makeConstraints { make in
            make.top.equalTo(textField4.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }

        automechanicButton.snp.makeConstraints { make in
            make.top.equalTo(myPageDesignStackView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(50)
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
