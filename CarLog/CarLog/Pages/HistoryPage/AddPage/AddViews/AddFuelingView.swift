//
//  AddFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddFuelingView: UIView {
    
    lazy var oliTypeLabel: UILabel = {
        let oliTypeLabel = UILabel()
        oliTypeLabel.customLabel(text: "휘발유 or 경유", textColor: .black, font: Constants.fontJua28 ?? UIFont(), alignment: .center)
        return oliTypeLabel
    }()
    
    lazy var addPhotoButton: UIButton = {
        let addPhotoButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 60, weight: .regular))
        addPhotoButton.configuration = config
        addPhotoButton.layer.cornerRadius = 10
        return addPhotoButton
    }()
    
    lazy var inputFuelingStackView: UIStackView = {
        let inputFuelingStackView = UIStackView(arrangedSubviews: [totalDistanceStackView, priceStackView, countStackView, totalPriceStackView])
        inputFuelingStackView.customStackView(spacing: 20, axis: .vertical, alignment: .fill)
        return inputFuelingStackView
    }()
    
    lazy var totalDistanceStackView: UIStackView = {
        let totalDistanceStackView = UIStackView(arrangedSubviews: [totalDistanceLabel, totalDistanceTextField])
        totalDistanceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalDistanceStackView.distribution = .fillEqually
        return totalDistanceStackView
    }()
    
    lazy var totalDistanceLabel: UILabel = {
        let totalDistanceLabel = UILabel()
        totalDistanceLabel.customLabel(text: "누적\n주행거리", textColor: .white, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        totalDistanceLabel.numberOfLines = 2
        totalDistanceLabel.backgroundColor = UIColor.primaryColor
        totalDistanceLabel.layer.cornerRadius = 10
        totalDistanceLabel.clipsToBounds = true
        return totalDistanceLabel
    }()
    
//    lazy var emailTextField: UITextField = {
//        let textField = UITextField()
//        textField.loginCustomTextField(placeholder: "아이디 입력", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .left, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)))
//        return textField
//    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
//        totalDistanceTextField.placeholder = "ex) 17655"
//        
//        totalDistanceTextField.customTextField(placeholder: "ex) 17655", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .right)
        totalDistanceTextField.loginCustomTextField(placeholder: "ex) 17655", textColor: .lightGray, font: Constants.fontJua16 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 15, height: totalDistanceTextField.frame.size.height)))
        totalDistanceTextField.layer.borderWidth = 1
        totalDistanceTextField.layer.cornerRadius = 4
        totalDistanceTextField.textAlignment = .right
        totalDistanceTextField.keyboardType = .decimalPad
        return totalDistanceTextField
    }()
    
    lazy var kmLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.customLabel(text: "km", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return wonLabel
    }()
    
    lazy var priceStackView: UIStackView = {
        let priceStackView = UIStackView(arrangedSubviews: [priceLabel, priceTextField, wonLabel])
        priceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        priceStackView.distribution = .fillEqually
        return priceStackView
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.customLabel(text: "단가", textColor: .white, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        priceLabel.backgroundColor = UIColor.primaryColor
        priceLabel.layer.cornerRadius = 10
        priceLabel.clipsToBounds = true
        return priceLabel
    }()
    
    lazy var priceTextField: UITextField = {
        let priceTextField = UITextField()
        priceTextField.placeholder = "ex) 1766"
        priceTextField.textAlignment = .right
        priceTextField.keyboardType = .decimalPad
        return priceTextField
    }()
    
    lazy var wonLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.customLabel(text: "원", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return wonLabel
    }()
    
    lazy var countStackView: UIStackView = {
        let countStackView = UIStackView(arrangedSubviews: [countLabel, countTextField, lLabel])
        countStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        countStackView.distribution = .fillEqually
        return countStackView
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.customLabel(text: "수량", textColor: .white, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        countLabel.backgroundColor = UIColor.primaryColor
        countLabel.layer.cornerRadius = 10
        countLabel.clipsToBounds = true
        return countLabel
    }()
    
    lazy var countTextField: UITextField = {
        let countTextField = UITextField()
        countTextField.placeholder = "ex) 55.12"
        countTextField.textAlignment = .right
        countTextField.keyboardType = .decimalPad
        return countTextField
    }()
    
    lazy var lLabel: UILabel = {
        let wonLabel = UILabel()
        wonLabel.customLabel(text: "L", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return wonLabel
    }()
    
    lazy var totalPriceStackView: UIStackView = {
        let totalPriceStackView = UIStackView(arrangedSubviews: [totalPriceLabel, totalPriceTextField, wonLabel2])
        totalPriceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalPriceStackView.distribution = .fillEqually
        return totalPriceStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.customLabel(text: "총액", textColor: .white, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        totalPriceLabel.backgroundColor = UIColor.primaryColor
        totalPriceLabel.layer.cornerRadius = 10
        totalPriceLabel.clipsToBounds = true
        return totalPriceLabel
    }()
    
    lazy var totalPriceTextField: UITextField = {
        let totalPriceTextField = UITextField()
        totalPriceTextField.placeholder = "ex) 100000"
        totalPriceTextField.textAlignment = .right
        totalPriceTextField.keyboardType = .decimalPad
        return totalPriceTextField
    }()
    
    lazy var wonLabel2: UILabel = {
        let wonLabel2 = UILabel()
        wonLabel2.customLabel(text: "원", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .center)
        return wonLabel2
    }()
    
    lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView(arrangedSubviews: [saveButton, cancelButton])
        buttonStackView.customStackView(spacing: Constants.horizontalMargin, axis: .vertical, alignment: .fill)
        return buttonStackView
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.customButton(text: "저장", font: Constants.fontJua24 ?? UIFont(), titleColor: .white, backgroundColor: .primaryColor)
        saveButton.layer.cornerRadius = 10
        return saveButton
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.customButton(text: "취소", font: Constants.fontJua24 ?? UIFont(), titleColor: .white, backgroundColor: .primaryColor)
        cancelButton.layer.cornerRadius = 10
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
        addSubview(oliTypeLabel)
        addSubview(addPhotoButton)
        addSubview(inputFuelingStackView)
        addSubview(buttonStackView)
        
        oliTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(oliTypeLabel.snp.bottom).offset(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.verticalMargin)
        }
        
        inputFuelingStackView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(inputFuelingStackView.snp.bottom).offset(Constants.horizontalMargin)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
    }

}
