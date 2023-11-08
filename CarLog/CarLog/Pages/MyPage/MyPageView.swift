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
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        let image = UIImage(systemName: "xmark.circle", withConfiguration: imageConfig)
        cancelButton.setImage(image, for: .normal)
        cancelButton.tintColor = .black
        cancelButton.isHidden = true
        return cancelButton
    }()
    
    // MARK: -
    //    텍스트 폰트에 따른 언더라인 수정
    //    lazy var myWritingButton: UIButton = {
    //        let myWritingButton = UIButton()
    //        myWritingButton.customButton(text: "내가 작성한 글", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
    //        return myWritingButton
    //    }()
    
    lazy var carNumberLabel: UILabel = {
        let carNumberLabel = UILabel()
        carNumberLabel.text = "차량 번호"
        carNumberLabel.textColor = .mainNavyColor
        carNumberLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNumberLabel
    }()
    
    lazy var carNumberTextField: UITextField = {
        let carNumberTextField = UITextField()
        carNumberTextField.mypageCustomTextField(placeholder: "차량 번호 ex)00가0000", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        carNumberTextField.rightView = checkCarNumberButton
        carNumberTextField.rightViewMode = .always
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNumberTextField.inputAccessoryView = toolbar
        return carNumberTextField
    }()
    
    lazy var checkCarNumberButton: UIButton = {
        let checkCarNumberButton = UIButton()
        checkCarNumberButton.myPageCustomButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold), titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
        checkCarNumberButton.isHidden = true
        return checkCarNumberButton
    }()
    
    lazy var carNameLabel: UILabel = {
        let carNameLabel = UILabel()
        carNameLabel.text = "차 종류"
        carNameLabel.textColor = .mainNavyColor
        carNameLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNameLabel
    }()
    
    lazy var carNameTextField: UITextField = {
        let carNameTextField = UITextField()
        carNameTextField.mypageCustomTextField(placeholder: "차 종류", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNameTextField.inputAccessoryView = toolbar
        return carNameTextField
    }()
    
    lazy var carMakerLabel: UILabel = {
        let carMakerLabel = UILabel()
        carMakerLabel.text = "제조사"
        carMakerLabel.textColor = .mainNavyColor
        carMakerLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carMakerLabel
    }()
    
    lazy var carMakerTextField: UITextField = {
        let carMakerTextField = UITextField()
        carMakerTextField.mypageCustomTextField(placeholder: "제조사", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carMakerTextField.inputAccessoryView = toolbar
        return carMakerTextField
    }()
    
    lazy var carOilTypeLabel: UILabel = {
        let carOilTypeLabel = UILabel()
        carOilTypeLabel.text = "연료 종류"
        carOilTypeLabel.textColor = .mainNavyColor
        carOilTypeLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carOilTypeLabel
    }()
    
    lazy var carOilTypeTextField: UITextField = {
        let carOilTypeTextField = UITextField()
        carOilTypeTextField.mypageCustomTextField(placeholder: "연료 종류", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carOilTypeTextField.inputAccessoryView = toolbar
        return carOilTypeTextField
    }()
    
    lazy var carNickNameLabel: UILabel = {
        let carNickNameLabel = UILabel()
        carNickNameLabel.text = "차량 별명"
        carNickNameLabel.textColor = .mainNavyColor
        carNickNameLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carNickNameLabel
    }()
    
    lazy var carNickNameTextField: UITextField = {
        let carNickNameTextField = UITextField()
        carNickNameTextField.mypageCustomTextField(placeholder: "차량 별명(닉네임)", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        carNickNameTextField.rightView = checkCarNickNameButton
        carNickNameTextField.rightViewMode = .always
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carNickNameTextField.inputAccessoryView = toolbar
        return carNickNameTextField
    }()
    
    lazy var checkCarNickNameButton: UIButton = {
        let checkCarNickNameButton = UIButton()
        checkCarNickNameButton.myPageCustomButton(text: "중복확인", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold), titleColor: .buttonSkyBlueColor, backgroundColor: .mainNavyColor)
        checkCarNickNameButton.isHidden = true
        return checkCarNickNameButton
    }()
    
    lazy var carTotalDistanceLabel: UILabel = {
        let carTotalDistanceLabel = UILabel()
        carTotalDistanceLabel.text = "최종 주행거리"
        carTotalDistanceLabel.textColor = .mainNavyColor
        carTotalDistanceLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return carTotalDistanceLabel
    }()
    
    lazy var carTotalDistanceTextField: UITextField = {
        let carTotalDistanceTextField = UITextField()
        carTotalDistanceTextField.mypageCustomTextField(placeholder: "최종 주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(closeKeyboard))
        toolbar.setItems([flexibleSpace, closeButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        carTotalDistanceTextField.inputAccessoryView = toolbar
        return carTotalDistanceTextField
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
        let quitUserButton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .regular),
            .foregroundColor: UIColor.lightGray,
        ]
        let attributedTitle = NSAttributedString(string: "회원탈퇴", attributes: attributes)
        quitUserButton.setAttributedTitle(attributedTitle, for: .normal)
        quitUserButton.backgroundColor = .clear
        return quitUserButton
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
    
    lazy var verLabel: UILabel = {
        let verLabel = UILabel()
        verLabel.text = "ver x.x.x"
        verLabel.textColor = .lightGray
        verLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold)
        verLabel.textAlignment = .center
        return verLabel
    }()
    
    lazy var personalRegulations: UILabel = {
        let personalRegulations = UILabel()
        personalRegulations.text = "개인정보처리방침"
        personalRegulations.textColor = .lightGray
        personalRegulations.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .bold)
        personalRegulations.textAlignment = .center
        personalRegulations.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        personalRegulations.addGestureRecognizer(tap)
        return personalRegulations
    }()
    
    @objc func tapFunction(sender: UITapGestureRecognizer) {
        if let url = URL(string: "https://carlog.notion.site/3b018e85e94443da9a8d533525d3cf64?pvs=4") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [/*myWritingButton,*/ carNumberLabel, carNumberTextField, carNameLabel, carNameTextField, carMakerLabel, carMakerTextField, carOilTypeLabel, carOilTypeTextField, carNickNameLabel, carNickNameTextField, carTotalDistanceLabel, carTotalDistanceTextField])
        stackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        return stackView
    }()
    
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
        
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(cancelButton)
        contentView.addSubview(carNumberLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(myPageDesignStackView)
        contentView.addSubview(phoneCallButton)
        contentView.addSubview(verLabel)
        contentView.addSubview(personalRegulations)
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        carNumberTextField.isUserInteractionEnabled = false
        carNameTextField.isUserInteractionEnabled = false
        carMakerTextField.isUserInteractionEnabled = false
        carOilTypeTextField.isUserInteractionEnabled = false
        carNickNameTextField.isUserInteractionEnabled = false
        carTotalDistanceTextField.isUserInteractionEnabled = false
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            verLabel.text = "Ver \(version)"
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.trailing.equalTo(editButton.snp.trailing).offset(-Constants.horizontalMargin * 3)
        }
        
        //        myWritingButton.snp.makeConstraints { make in
        //            make.width.equalTo(80)
        //            make.height.equalTo(60)
        //        }
        
        carNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(carNumberLabel.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
        }
        
        checkCarNumberButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        carNickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(carNickNameLabel.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
        }
        
        checkCarNickNameButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        myPageDesignStackView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(Constants.verticalMargin * 5)
            make.leading.equalTo(contentView.snp.leading).offset(UIScreen.main.bounds.width * 0.3)
            make.trailing.equalTo(contentView.snp.trailing).offset(-UIScreen.main.bounds.width * 0.3)
        }
        
        phoneCallButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(Constants.verticalMargin * 3.5)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 53, height: 53))
        }
        
        verLabel.snp.makeConstraints { make in
            make.top.equalTo(myPageDesignStackView.snp.bottom).offset(7)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        personalRegulations.snp.makeConstraints { make in
            make.top.equalTo(verLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
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
