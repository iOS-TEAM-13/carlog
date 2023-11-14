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
    
//    lazy var mainTitleLabel: UILabel = {
//        let mainTitleLabel = UILabel()
//        mainTitleLabel.text = " 내 차 정보"
//        mainTitleLabel.textColor = .white
//        mainTitleLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua28, weight: .bold)
//        mainTitleLabel.layer.backgroundColor = UIColor.mainNavyColor.cgColor
//        mainTitleLabel.layer.bounds.size.height = 50
//        mainTitleLabel.layer.cornerRadius = 5
//        mainTitleLabel.rightView = editButton
//        mainTitleLabel.rightViewMode = .always
//        mainTitleLabel.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: mainTitleLabel.frame.size.height))
//        mainTitleLabel.leftViewMode = .always
//        return mainTitleLabel
//    }()
    
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
    
    // CarParts 부분별 스택뷰 묶음
    lazy var carNumberStackView: UIStackView = {
        let carNumberStackView = UIStackView(arrangedSubviews: [/*myWritingButton,*/ carNumberLabel, carNumberTextField])
        carNumberStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carNumberStackView
    }()
    
    lazy var carNameStackView: UIStackView = {
        let carNameStackView = UIStackView(arrangedSubviews: [carNameLabel, carNameTextField])
        carNameStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carNameStackView
    }()
    
    lazy var carMakerStackView: UIStackView = {
        let carMakerStackView = UIStackView(arrangedSubviews: [carMakerLabel, carMakerTextField])
        carMakerStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carMakerStackView
    }()
    
    lazy var carOilTypeStackView: UIStackView = {
        let carOilTypeStackView = UIStackView(arrangedSubviews: [carOilTypeLabel, carOilTypeTextField])
        carOilTypeStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carOilTypeStackView
    }()
    
    lazy var carNickNameStackView: UIStackView = {
        let carNickNameStackView = UIStackView(arrangedSubviews: [carNickNameLabel, carNickNameTextField])
        carNickNameStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carNickNameStackView
    }()
    
    lazy var carTotalDistanceStackView: UIStackView = {
        let carTotalDistanceStackView = UIStackView(arrangedSubviews: [carTotalDistanceLabel, carTotalDistanceTextField])
        carTotalDistanceStackView.customStackView(spacing: 0.5, axis: .vertical, alignment: .fill)
        return carTotalDistanceStackView
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
    func updateMainTitleLabel() {
            mainTitleLabel.sizeToFit()
            layoutIfNeeded()
        }
    
    func setupUI() {
        let safeArea = safeAreaLayoutGuide
        
        contentView.addSubview(mainTitleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(cancelButton)
        contentView.addSubview(carNumberLabel)
        contentView.addSubview(carNumberStackView)
        contentView.addSubview(carNameStackView)
        contentView.addSubview(carMakerStackView)
        contentView.addSubview(carOilTypeStackView)
        contentView.addSubview(carNickNameStackView)
        contentView.addSubview(carTotalDistanceStackView)
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        carNumberTextField.isUserInteractionEnabled = false
        carNameTextField.isUserInteractionEnabled = false
        carMakerTextField.isUserInteractionEnabled = false
        carOilTypeTextField.isUserInteractionEnabled = false
        carNickNameTextField.isUserInteractionEnabled = false
        carTotalDistanceTextField.isUserInteractionEnabled = false
        
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
        
        // CarParts 부분별 스택뷰 제약
        carNumberStackView.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(Constants.verticalMargin * 3)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        checkCarNumberButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        carNameStackView.snp.makeConstraints { make in
            make.top.equalTo(carNumberStackView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        carMakerStackView.snp.makeConstraints { make in
            make.top.equalTo(carNameStackView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        carOilTypeStackView.snp.makeConstraints { make in
            make.top.equalTo(carMakerStackView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        carNickNameStackView.snp.makeConstraints { make in
            make.top.equalTo(carOilTypeStackView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        checkCarNickNameButton.snp.makeConstraints { make in
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        carTotalDistanceStackView.snp.makeConstraints { make in
            make.top.equalTo(carNickNameStackView.snp.bottom).offset(15)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
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
