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
        addFuelingPageLabel.customLabel(text: "휘발유", textColor: .black, font: Constants.fontJua28 ?? UIFont(), alignment: .center)
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
        totalDistanceLabel.customLabel(text: "누적\n주행거리", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        totalDistanceLabel.numberOfLines = 2
        return totalDistanceLabel
    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
        totalDistanceTextField.historyCustomTextField(placeholder: "ex) 17655", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 40, height: totalDistanceTextField.frame.size.height)))
        totalDistanceTextField.layer.borderWidth = 1.5
        totalDistanceTextField.layer.cornerRadius = Constants.cornerRadius
        totalDistanceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.nextPriceTextField))
        nextTextField.setItems([flexibleSpace, nextButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        totalDistanceTextField.inputAccessoryView = nextTextField
        
        return totalDistanceTextField
    }()
    
    @objc func nextPriceTextField() {
        self.priceTextField.becomeFirstResponder()
    }
    
    lazy var priceStackView: UIStackView = {
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel, priceTextField])
        priceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        priceStackView.distribution = .fill
        return priceStackView
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.customLabel(text: "단가", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return priceLabel
    }()
    
    lazy var priceTextField: UITextField = {
        let priceTextField = UITextField()
        priceTextField.historyCustomTextField(placeholder: "ex) 1765", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 34, height: priceTextField.frame.size.height)))
        priceTextField.layer.borderWidth = 1.5
        priceTextField.layer.cornerRadius = Constants.cornerRadius
        priceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.beforeTotalDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.nextCountTextField))
        nextTextField.setItems([beforeButton, flexibleSpace, nextButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        priceTextField.inputAccessoryView = nextTextField
        
        return priceTextField
    }()
    
    @objc func beforeTotalDistanceTextField() {
        self.totalDistanceTextField.becomeFirstResponder()
    }
    
    @objc func nextCountTextField() {
        self.countTextField.becomeFirstResponder()
    }
    
    lazy var countStackView: UIStackView = {
        let countStackView = UIStackView(arrangedSubviews: [countLabel, countTextField])
        countStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        countStackView.distribution = .fill
        return countStackView
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.customLabel(text: "수량", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return countLabel
    }()
    
    lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        countTextField.historyCustomTextField(placeholder: "ex) 55.123 / 55", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 29, height: countTextField.frame.size.height)))
        countTextField.layer.borderWidth = 1.5
        countTextField.layer.cornerRadius = Constants.cornerRadius
        countTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.beforeTotalPriceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.nextTotalPriceTextField))
        nextTextField.setItems([beforeButton, flexibleSpace, nextButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        countTextField.inputAccessoryView = nextTextField
        
        return countTextField
    }()
    
    @objc func beforeTotalPriceTextField() {
        self.priceTextField.becomeFirstResponder()
    }
    
    @objc func nextTotalPriceTextField() {
        self.totalPriceTextField.becomeFirstResponder()
    }
    
    lazy var totalPriceStackView: UIStackView = {
        let totalPriceStackView = UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceTextField])
        totalPriceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalPriceStackView.distribution = .fill
        return totalPriceStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.customLabel(text: "총액", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return totalPriceLabel
    }()
    
    lazy var totalPriceTextField: UITextField = {
        let totalPriceTextField = UITextField()
        totalPriceTextField.historyCustomTextField(placeholder: "ex) 100000", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 34, height: totalPriceTextField.frame.size.height)))
        totalPriceTextField.layer.borderWidth = 1.5
        totalPriceTextField.layer.cornerRadius = Constants.cornerRadius
        totalPriceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.beforeCountTextField))
        nextTextField.setItems([beforeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        totalPriceTextField.inputAccessoryView = nextTextField
        
        return totalPriceTextField
    }()
    
    @objc func beforeCountTextField() {
        self.countTextField.becomeFirstResponder()
    }
    
    //MARK: - 단위 Label
    lazy var kmLabel: UILabel = {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return kmLabel
    }()
    
    lazy var wonLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.customLabel(text: "원", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return wonLabel
    }()
    
    lazy var lLabel: UILabel = {
        let lLabel = UILabel()
        lLabel.customLabel(text: "L", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return lLabel
    }()
    
    lazy var wonLabel2: UILabel = {
        let wonLabel2 = UILabel()
        wonLabel2.customLabel(text: "원", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
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
        saveButton.customButton(text: "저장", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
        saveButton.layer.cornerRadius = Constants.cornerRadius
        return saveButton
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.customButton(text: "취소", font: Constants.fontJua24 ?? UIFont(), titleColor: .primaryColor, backgroundColor: .thirdColor)
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
