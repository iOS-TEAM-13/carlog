//
//  AddFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import UIKit
import SnapKit

class AddFuelingView: UIView {
    
    //MARK: - 스크롤뷰 추가
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    //MARK: - 주유 기록 페이지 전체 스택뷰
    lazy var inputFuelingStackView: UIStackView = {
        let inputFuelingStackView = UIStackView(arrangedSubviews: [totalDistanceStackView, priceStackView, countStackView, totalPriceStackView])
        inputFuelingStackView.customStackView(spacing: 20, axis: .vertical, alignment: .center)
        inputFuelingStackView.backgroundColor = .white
        inputFuelingStackView.layer.cornerRadius = Constants.cornerRadius
        return inputFuelingStackView
    }()
    
    //MARK: - 누적 주행거리 영역
    lazy var totalDistanceStackView: UIStackView = {
        let totalDistanceStackView = UIStackView(arrangedSubviews: [totalDistanceLabel, totalDistanceTextField])
        totalDistanceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        totalDistanceStackView.distribution = .fill
        return totalDistanceStackView
    }()
    
    lazy var totalDistanceLabel: UILabel = {
        let totalDistanceLabel = UILabel()
        totalDistanceLabel.customLabel(text: "누적 주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return totalDistanceLabel
    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        totalDistanceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10010", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: AddDrivingView().drivingPurposeTextField.frame.size.height)), keyboardType: .decimalPad)
        
        totalDistanceTextField.rightView?.addSubview(UILabel.kmUnitLabel())
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toTotalPriceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toPriceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeTotalDistanceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        
        nextTextField.isUserInteractionEnabled = true
        totalDistanceTextField.inputAccessoryView = nextTextField
        
        return totalDistanceTextField
    }()
    
    @objc func toTotalPriceTextField() {
        totalPriceTextField.becomeFirstResponder()
    }
    
    @objc func toPriceTextField() {
        priceTextField.becomeFirstResponder()
    }
    
    @objc func closeTotalDistanceTextField() {
        totalDistanceTextField.resignFirstResponder()
    }
    
    //MARK: - 단가 영역
    lazy var priceStackView: UIStackView = {
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel, priceTextField])
        priceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        priceStackView.distribution = .fill
        return priceStackView
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.customLabel(text: "단가", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return priceLabel
    }()
    
    lazy var priceTextField: UITextField = {
        let priceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        priceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 1777", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: totalDistanceTextField.frame.size.height)), keyboardType: .decimalPad)
        
        priceTextField.rightView?.addSubview(UILabel.wonUnitLabel())
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toCountTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closePriceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        
        nextTextField.isUserInteractionEnabled = true
        priceTextField.inputAccessoryView = nextTextField
        
        return priceTextField
    }()
    
    @objc func toTotalDistanceTextField() {
        totalDistanceTextField.becomeFirstResponder()
    }
    
    @objc func toCountTextField() {
        countTextField.becomeFirstResponder()
    }
    
    @objc func closePriceTextField() {
        priceTextField.resignFirstResponder()
    }
    
    //MARK: - 수량 영역
    lazy var countStackView: UIStackView = {
        let countStackView = UIStackView(arrangedSubviews: [countLabel, countTextField])
        countStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        countStackView.distribution = .fill
        return countStackView
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.customLabel(text: "수량", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return countLabel
    }()
    
    lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        countTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 55.123 / 55", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: totalDistanceTextField.frame.size.height)), keyboardType: .decimalPad)
        
        countTextField.rightView?.addSubview(UILabel.literUnitLabel())
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toPriceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toTotalPriceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeCountTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        countTextField.inputAccessoryView = nextTextField
        
        return countTextField
    }()
    
    @objc func closeCountTextField() {
        countTextField.resignFirstResponder()
    }
    
    //MARK: - 총액 영역
    lazy var totalPriceStackView: UIStackView = {
        let totalPriceStackView = UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceTextField])
        totalPriceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        totalPriceStackView.distribution = .fill
        return totalPriceStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.customLabel(text: "총액", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return totalPriceLabel
    }()
    
    lazy var totalPriceTextField: UITextField = {
        let totalPriceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        totalPriceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 100000", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: totalDistanceTextField.frame.size.height)), keyboardType: .decimalPad)
        
        totalPriceTextField.rightView?.addSubview(UILabel.wonUnitLabel())
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toCountTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeTotalPriceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        totalPriceTextField.inputAccessoryView = nextTextField
        
        return totalPriceTextField
    }()
    
    @objc func closeTotalPriceTextField() {
        totalPriceTextField.resignFirstResponder()
    }
    
    // MARK: - 취소, 저장 버튼 영역
    lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        buttonStackView.customStackView(spacing: 60, axis: .horizontal, alignment: .fill)
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.customButton(text: "저장", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
        saveButton.layer.cornerRadius = Constants.cornerRadius
        return saveButton
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.customButton(text: "취소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
        cancelButton.layer.cornerRadius = Constants.cornerRadius
        return cancelButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addFuelingView UI 설정
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(inputFuelingStackView)
        contentView.addSubview(buttonStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        inputFuelingStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        totalDistanceStackView.snp.makeConstraints { make in
            make.top.equalTo(inputFuelingStackView.snp.top).offset(Constants.horizontalMargin * 2)
            make.leading.equalTo(inputFuelingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(inputFuelingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(totalDistanceStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
            make.leading.equalTo(inputFuelingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(inputFuelingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
        }
        
        countStackView.snp.makeConstraints { make in
            make.top.equalTo(priceStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
            make.leading.equalTo(inputFuelingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(inputFuelingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
        }
        
        totalPriceStackView.snp.makeConstraints { make in
            make.top.equalTo(countStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
            make.leading.equalTo(inputFuelingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
            make.trailing.equalTo(inputFuelingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
            make.bottom.equalTo(inputFuelingStackView.snp.bottom).offset(-Constants.horizontalMargin * 2)
        }
        
        totalPriceTextField.snp.makeConstraints { make in
            make.bottom.equalTo(inputFuelingStackView.snp.bottom).offset(-Constants.horizontalMargin * 2)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(contentView).offset(-Constants.verticalMargin)
            make.height.equalTo(50)
        }
    }
}
