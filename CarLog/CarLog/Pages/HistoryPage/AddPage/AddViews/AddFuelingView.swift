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
        config.image = UIImage(systemName: "photo")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        addPhotoButton.configuration = config
        addPhotoButton.backgroundColor = .primaryColor
        addPhotoButton.layer.cornerRadius = 10
        return addPhotoButton
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
        totalDistanceTextField.layer.borderWidth = 1
        totalDistanceTextField.layer.cornerRadius = 4
        totalDistanceTextField.keyboardType = .decimalPad
        return totalDistanceTextField
    }()
    
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
        priceTextField.historyCustomTextField(placeholder: "ex) 1765", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 34, height: totalPriceTextField.frame.size.height)))
        priceTextField.layer.borderWidth = 1
        priceTextField.layer.cornerRadius = 4
        priceTextField.keyboardType = .decimalPad
        return priceTextField
    }()
    
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
        countTextField.historyCustomTextField(placeholder: "ex) 55.12 / 55", textColor: .black, font: Constants.fontJua20 ?? UIFont(), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 29, height: countTextField.frame.size.height)))
        countTextField.layer.borderWidth = 1
        countTextField.layer.cornerRadius = 4
        countTextField.keyboardType = .decimalPad
        return countTextField
    }()
    
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
        totalPriceTextField.layer.borderWidth = 1
        totalPriceTextField.layer.cornerRadius = 4
        totalPriceTextField.keyboardType = .decimalPad
        return totalPriceTextField
    }()
    
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
        buttonStackView.customStackView(spacing: 20, axis: .horizontal, alignment: .fill)
        buttonStackView.distribution = .fillEqually
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
        
        totalDistanceStackView.addSubview(kmLabel)
        priceStackView.addSubview(wonLabel)
        countStackView.addSubview(lLabel)
        totalPriceStackView.addSubview(wonLabel2)
        
        oliTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(oliTypeLabel.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.verticalMargin)
//            make.height.equalTo(80)
        }
        
        totalDistanceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addPhotoButton.snp.trailing)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addPhotoButton.snp.trailing)
        }
        
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addPhotoButton.snp.trailing)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(addPhotoButton.snp.trailing)
        }
        
        inputFuelingStackView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
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
            make.top.equalTo(inputFuelingStackView.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
    }

}
