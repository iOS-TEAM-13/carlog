//
//  MyPageView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 2023/10/13.
//

import UIKit

import SnapKit

final class MyPageView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    // MARK: -
    
    lazy var mainTitleLabel: UILabel = {
        let mainTitleLabel = UILabel()
        mainTitleLabel.text = "내 차 정보"
        mainTitleLabel.textColor = .black
        mainTitleLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua28, weight: .bold)
        return mainTitleLabel
    }()
    
    lazy var editButton: UIButton = {
        let editButton = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        let image = UIImage(systemName: "highlighter", withConfiguration: imageConfig)
        editButton.setImage(image, for: .normal)
        editButton.tintColor = .black
        return editButton
    }()
    
    // MARK: -
    
    //    //텍스트 폰트에 따른 언더라인 수정
    //    lazy var myWritingButton: UIButton = {
    //        let myWritingButton = UIButton()
    //        myWritingButton.customButton(text: "내가 작성한 글", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
    //        return myWritingButton  // ⭐ 나중에 Community Page 연결 필요
    //    }()
    
    lazy var carNumberLabel: UILabel = {
        let carNumberLabel = UILabel()
        carNumberLabel.text = "차량 번호"
        carNumberLabel.textColor = .mainNavyColor
        carNumberLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNumberLabel
    }()
    
    
    lazy var carNumberTextField: UITextField = {
        let carNumbertextField = UITextField()
        carNumbertextField.mypageCustomTextField(placeholder: "차량 번호 ex)00가0000", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNumbertextField.inputAccessoryView = toolbar
        return carNumbertextField
    }()
    
    lazy var carNameLabel: UILabel = {
        let carNameLabel = UILabel()
        carNameLabel.text = "차 종류"
        carNameLabel.textColor = .mainNavyColor
        carNameLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNameLabel
    }()
    
    lazy var carNameTextField: UITextField = {
        let carNametextField = UITextField()
        carNametextField.mypageCustomTextField(placeholder: "차 종류", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNametextField.inputAccessoryView = toolbar
        return carNametextField
    }()
    
    lazy var carMakerLabel: UILabel = {
        let carMakerLabel = UILabel()
        carMakerLabel.text = "제조사"
        carMakerLabel.textColor = .mainNavyColor
        carMakerLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carMakerLabel
    }()
    
    lazy var carMakerTextField: UITextField = {
        let carMakertextField = UITextField()
        carMakertextField.mypageCustomTextField(placeholder: "제조사", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carMakertextField.inputAccessoryView = toolbar
        return carMakertextField
    }()
    
    lazy var carOilTypeLabel: UILabel = {
        let carOilTypeLabel = UILabel()
        carOilTypeLabel.text = "연료 종류"
        carOilTypeLabel.textColor = .mainNavyColor
        carOilTypeLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carOilTypeLabel
    }()
    
    lazy var carOilTypeTextField: UITextField = {
        let carOilTypetextField = UITextField()
        carOilTypetextField.mypageCustomTextField(placeholder: "연료 종류", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carOilTypetextField.inputAccessoryView = toolbar
        return carOilTypetextField
    }()
    
    lazy var carNickNameLabel: UILabel = {
        let carNickNameLabel = UILabel()
        carNickNameLabel.text = "차량 별명"
        carNickNameLabel.textColor = .mainNavyColor
        carNickNameLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNickNameLabel
    }()
    
    lazy var carNickNameTextField: UITextField = {
        let carNickNametextField = UITextField()
        carNickNametextField.mypageCustomTextField(placeholder: "차량 별명(닉네임)", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNickNametextField.inputAccessoryView = toolbar
        return carNickNametextField
    }()
    
    lazy var carTotalDistanceLabel: UILabel = {
        let carTotalDistanceLabel = UILabel()
        carTotalDistanceLabel.text = "최종 주행거리"
        carTotalDistanceLabel.textColor = .mainNavyColor
        carTotalDistanceLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carTotalDistanceLabel
    }()
    
    lazy var carTotalDistanceTextField: UITextField = {
        let carTotalDistancetextField = UITextField()
        carTotalDistancetextField.mypageCustomTextField(placeholder: "최종 주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carTotalDistancetextField.inputAccessoryView = toolbar
        return carTotalDistancetextField
    }()
    
    lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .regular),
            .foregroundColor: UIColor.lightGray,
        ]
        let attributedTitle = NSAttributedString(string: "로그아웃", attributes: attributes)
        logoutButton.setAttributedTitle(attributedTitle, for: .normal)
        logoutButton.backgroundColor = .clear
        return logoutButton
    }()
    
    lazy var horizontalDivider: UIView = {
        let horizontalDivider = UIView()
        horizontalDivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalDivider.heightAnchor.constraint(equalToConstant: 15).isActive = true
        horizontalDivider.backgroundColor = .lightGray
        return horizontalDivider
    }()
    
    lazy var quitUserButton: UIButton = {
        let quitUserbutton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .regular),
            .foregroundColor: UIColor.lightGray,
        ]
        let attributedTitle = NSAttributedString(string: "회원탈퇴", attributes: attributes)
        quitUserbutton.setAttributedTitle(attributedTitle, for: .normal)
        quitUserbutton.backgroundColor = .clear
        return quitUserbutton
    }()
    
    lazy var myPageDesignStackView = {
        let myPageDesignStackView = UIStackView(arrangedSubviews: [logoutButton, horizontalDivider, quitUserButton])
        myPageDesignStackView.customStackView(spacing: 5, axis: .horizontal, alignment: .center)
        myPageDesignStackView.distribution = .equalSpacing
        return myPageDesignStackView
    }()
    
    lazy var phoneCallButton: UIButton = {
        let phoneCallButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.cornerStyle = .capsule
        config.image = UIImage(named: "Context Icon")
        phoneCallButton.configuration = config
        phoneCallButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        phoneCallButton.layer.shadowRadius = 10
        phoneCallButton.layer.shadowOpacity = 0.1
        return phoneCallButton
    }()
    
    private func makeLabel(text: String, textColor: UIColor, font: UIFont, alignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.customLabel(text: text, textColor: textColor, font: font, alignment: alignment)
        return label
    }
    
    @objc func closeKeyboard() {
        carNumberTextField.resignFirstResponder()
        carNameTextField.resignFirstResponder()
        carMakerTextField.resignFirstResponder()
        carOilTypeTextField.resignFirstResponder()
        carNickNameTextField.resignFirstResponder()
        carTotalDistanceTextField.resignFirstResponder()
    }
    
    // MARK: -
    
    func setupUI() {
        let safeArea = safeAreaLayoutGuide
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(carNumberLabel)
        //      contentView.addSubview(myWritingButton)
        contentView.addSubview(carNumberTextField)
        contentView.addSubview(carNameLabel)
        contentView.addSubview(carNameTextField)
        contentView.addSubview(carMakerLabel)
        contentView.addSubview(carMakerTextField)
        contentView.addSubview(carOilTypeLabel)
        contentView.addSubview(carOilTypeTextField)
        contentView.addSubview(carNickNameLabel)
        contentView.addSubview(carNickNameTextField)
        contentView.addSubview(carTotalDistanceLabel)
        contentView.addSubview(carTotalDistanceTextField)
        contentView.addSubview(myPageDesignStackView)
        contentView.addSubview(phoneCallButton)
        
        carNumberTextField.isUserInteractionEnabled = false
        carNameTextField.isUserInteractionEnabled = false
        carMakerTextField.isUserInteractionEnabled = false
        carOilTypeTextField.isUserInteractionEnabled = false
        carNickNameTextField.isUserInteractionEnabled = false
        carTotalDistanceTextField.isUserInteractionEnabled = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.trailing.equalTo(safeArea.snp.trailing)
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        //        myWritingButton.snp.makeConstraints { make in
        //            make.top.equalTo(mainTitleLabel.snp.bottom).offset(Constants.verticalMargin * 2.5)
        //            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
        //            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        //            make.width.equalTo(100)
        //            make.height.equalTo(70)
        //        }
        
        carNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(Constants.verticalMargin * 3)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(carNumberLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carNameLabel.snp.makeConstraints { make in
            make.top.equalTo(carNumberTextField.snp.bottom).offset(Constants.verticalMargin * 1.5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carNameTextField.snp.makeConstraints { make in
            make.top.equalTo(carNameLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carMakerLabel.snp.makeConstraints { make in
            make.top.equalTo(carNameTextField.snp.bottom).offset(Constants.verticalMargin * 1.5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carMakerTextField.snp.makeConstraints { make in
            make.top.equalTo(carMakerLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carOilTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(carMakerTextField.snp.bottom).offset(Constants.verticalMargin * 1.5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carOilTypeTextField.snp.makeConstraints { make in
            make.top.equalTo(carOilTypeLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carNickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(carOilTypeTextField.snp.bottom).offset(Constants.verticalMargin * 1.5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carNickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(carNickNameLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carTotalDistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(carNickNameTextField.snp.bottom).offset(Constants.verticalMargin * 1.5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        carTotalDistanceTextField.snp.makeConstraints { make in
            make.top.equalTo(carTotalDistanceLabel.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        myPageDesignStackView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-Constants.verticalMargin)
            make.leading.equalTo(contentView.snp.leading).offset(UIScreen.main.bounds.width * 0.3)
            make.trailing.equalTo(contentView.snp.trailing).offset(-UIScreen.main.bounds.width * 0.3)
        }
        
        phoneCallButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
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
