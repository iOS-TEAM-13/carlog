//
//  AddFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddFuelingView: UIView {
    
    lazy var addFuelingPageLabel: UILabel = {
        let addFuelingPageLabel = UILabel()
        addFuelingPageLabel.customLabel(text: "휘발유", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua28, weight: .medium), alignment: .center)
        return addFuelingPageLabel
    }()
    
    lazy var inputFuelingStackView: UIStackView = {
        let inputFuelingStackView = UIStackView(arrangedSubviews: [totalDistanceStackView, priceStackView, countStackView, totalPriceStackView])
        inputFuelingStackView.customStackView(spacing: 25, axis: .vertical, alignment: .fill)
        return inputFuelingStackView
    }()
    
    lazy var totalDistanceStackView: UIStackView = {
        let totalDistanceStackView = UIStackView(arrangedSubviews: [totalDistanceLabel, totalDistanceTextField])
        totalDistanceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalDistanceStackView.distribution = .fill
        return totalDistanceStackView
    }()
    
    lazy var totalDistanceLabel: UILabel = {
        let totalDistanceLabel = UILabel()
        totalDistanceLabel.customLabel(text: "누적\n주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        totalDistanceLabel.numberOfLines = 2
        return totalDistanceLabel
    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
        totalDistanceTextField.historyCustomTextField(placeholder: "ex) 10000", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 45, height: totalDistanceTextField.frame.size.height)))
        
        //placeholder color 적용
        let placeholderColor = UIColor.systemGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor, // 텍스트 색상 설정
        ]
        let attributedPlaceholder = NSAttributedString(string: "ex) 10000", attributes: attributes)
        totalDistanceTextField.attributedPlaceholder = attributedPlaceholder
        
        totalDistanceTextField.layer.borderWidth = 1.5
        totalDistanceTextField.layer.cornerRadius = Constants.cornerRadius
        totalDistanceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
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
        self.totalPriceTextField.becomeFirstResponder()
    }
    
    @objc func toPriceTextField() {
        self.priceTextField.becomeFirstResponder()
    }
    
    @objc func closeTotalDistanceTextField() {
        self.totalDistanceTextField.resignFirstResponder()
    }
    
    lazy var priceStackView: UIStackView = {
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel, priceTextField])
        priceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        priceStackView.distribution = .fill
        return priceStackView
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.customLabel(text: "단가", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return priceLabel
    }()
    
    lazy var priceTextField: UITextField = {
        let priceTextField = UITextField()
        priceTextField.historyCustomTextField(placeholder: "ex) 1765", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 35, height: priceTextField.frame.size.height)))
        
        //placeholder color 적용
        let placeholderColor = UIColor.systemGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor, // 텍스트 색상 설정
        ]
        let attributedPlaceholder = NSAttributedString(string: "ex) 1765", attributes: attributes)
        priceTextField.attributedPlaceholder = attributedPlaceholder
        
        priceTextField.layer.borderWidth = 1.5
        priceTextField.layer.cornerRadius = Constants.cornerRadius
        priceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
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
        self.totalDistanceTextField.becomeFirstResponder()
    }
    
    @objc func toCountTextField() {
        self.countTextField.becomeFirstResponder()
    }
    
    @objc func closePriceTextField() {
        self.priceTextField.resignFirstResponder()
    }
    
    lazy var countStackView: UIStackView = {
        let countStackView = UIStackView(arrangedSubviews: [countLabel, countTextField])
        countStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        countStackView.distribution = .fill
        return countStackView
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.customLabel(text: "수량", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return countLabel
    }()
    
    lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        countTextField.historyCustomTextField(placeholder: "ex) 55.123 / 55", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 30, height: countTextField.frame.size.height)))
        
        //placeholder color 적용
        let placeholderColor = UIColor.systemGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor, // 텍스트 색상 설정
        ]
        let attributedPlaceholder = NSAttributedString(string: "ex) 55.123 / 55", attributes: attributes)
        countTextField.attributedPlaceholder = attributedPlaceholder
        
        countTextField.layer.borderWidth = 1.5
        countTextField.layer.cornerRadius = Constants.cornerRadius
        countTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
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
        self.countTextField.resignFirstResponder()
    }
    
    lazy var totalPriceStackView: UIStackView = {
        let totalPriceStackView = UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceTextField])
        totalPriceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalPriceStackView.distribution = .fill
        return totalPriceStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.customLabel(text: "총액", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return totalPriceLabel
    }()
    
    lazy var totalPriceTextField: UITextField = {
        let totalPriceTextField = UITextField()
        totalPriceTextField.historyCustomTextField(placeholder: "ex) 100000", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 35, height: totalPriceTextField.frame.size.height)))
        
        //placeholder color 적용
        let placeholderColor = UIColor.systemGray
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor, // 텍스트 색상 설정
        ]
        let attributedPlaceholder = NSAttributedString(string: "ex) 100000", attributes: attributes)
        totalPriceTextField.attributedPlaceholder = attributedPlaceholder
        
        totalPriceTextField.layer.borderWidth = 1.5
        totalPriceTextField.layer.cornerRadius = Constants.cornerRadius
        totalPriceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
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
        self.totalPriceTextField.resignFirstResponder()
    }
    
    //MARK: - 단위 Label
    lazy var kmLabel: UILabel = {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return kmLabel
    }()
    
    lazy var wonLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.customLabel(text: "원", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return wonLabel
    }()
    
    lazy var lLabel: UILabel = {
        let lLabel = UILabel()
        lLabel.customLabel(text: "L", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return lLabel
    }()
    
    lazy var wonLabel2: UILabel = {
        let wonLabel2 = UILabel()
        wonLabel2.customLabel(text: "원", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return wonLabel2
    }()
    
    //MARK: - 버튼
    lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        buttonStackView.customStackView(spacing: 60, axis: .horizontal, alignment: .fill)
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.customButton(text: "저장", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
        saveButton.layer.cornerRadius = Constants.cornerRadius
        return saveButton
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.customButton(text: "취소", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
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
    
    private func setupUI() {
        addSubview(addFuelingPageLabel)
        addSubview(inputFuelingStackView)
        addSubview(buttonStackView)
        
        totalDistanceStackView.addSubview(kmLabel)
        priceStackView.addSubview(wonLabel)
        countStackView.addSubview(lLabel)
        totalPriceStackView.addSubview(wonLabel2)
        
        addFuelingPageLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        inputFuelingStackView.snp.makeConstraints { make in
            make.top.equalTo(addFuelingPageLabel.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        totalDistanceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        kmLabel.snp.makeConstraints { make in
            make.trailing.equalTo(totalDistanceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(totalDistanceStackView)
        }
        
        wonLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(priceStackView)
        }
        
        lLabel.snp.makeConstraints { make in
            make.trailing.equalTo(countStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(countStackView)
        }
        
        wonLabel2.snp.makeConstraints { make in
            make.trailing.equalTo(totalPriceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(totalPriceStackView)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(50)
        }
    }

}
