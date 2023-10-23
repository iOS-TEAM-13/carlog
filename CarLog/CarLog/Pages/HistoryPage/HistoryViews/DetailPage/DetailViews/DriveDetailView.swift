//
//  DriveDetailView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.
//

import UIKit

class DriveDetailView: UIView {

    lazy var addDrivingPageLabel: UILabel = {
        let addDrivingPageLabel = UILabel()
        addDrivingPageLabel.customLabel(text: "주행 기록", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua28, weight: .medium), alignment: .center)
        return addDrivingPageLabel
    }()
    
    lazy var inputDrivingStackView: UIStackView = {
        let inputDrivingStackView = UIStackView(arrangedSubviews: [totalDistanceStackView, arriveDistanceStackView, driveDistenceStackView])
        inputDrivingStackView.customStackView(spacing: 25, axis: .vertical, alignment: .fill)
        return inputDrivingStackView
    }()
    
    lazy var totalDistanceStackView: UIStackView = {
        let totalDistanceStackView = UIStackView(arrangedSubviews: [totalDistanceLabel, totalDistanceTextField])
        totalDistanceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        totalDistanceStackView.distribution = .fill
        return totalDistanceStackView
    }()
    
    lazy var totalDistanceLabel: UILabel = {
        let totalDistanceLabel = UILabel()
        totalDistanceLabel.customLabel(text: "누적(출발)\n주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        totalDistanceLabel.numberOfLines = 2
        return totalDistanceLabel
    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
        totalDistanceTextField.historyCustomTextField(placeholder: "ex) 17655", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 45, height: totalDistanceTextField.frame.size.height)))
        totalDistanceTextField.layer.borderWidth = 1.5
        totalDistanceTextField.layer.cornerRadius = Constants.cornerRadius
        totalDistanceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toDriveDistanceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toArriveDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeTotalDistanceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        totalDistanceTextField.inputAccessoryView = nextTextField
        
        return totalDistanceTextField
    }()
    
    @objc func toDriveDistanceTextField() {
        self.driveDistenceTextField.becomeFirstResponder()
    }
    
    @objc func toArriveDistanceTextField() {
        self.arriveDistanceTextField.becomeFirstResponder()
    }
    
    @objc func closeTotalDistanceTextField() {
        self.totalDistanceTextField.resignFirstResponder()
    }
    
    lazy var arriveDistanceStackView: UIStackView = {
        let arriveDistanceStackView = UIStackView(arrangedSubviews: [arriveDistanceLabel, arriveDistanceTextField])
        arriveDistanceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        arriveDistanceStackView.distribution = .fill
        return arriveDistanceStackView
    }()
    
    lazy var arriveDistanceLabel: UILabel = {
        let arriveDistanceLabel = UILabel()
        arriveDistanceLabel.customLabel(text: "도착\n주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        arriveDistanceLabel.numberOfLines = 2
        return arriveDistanceLabel
    }()
    
    lazy var arriveDistanceTextField: UITextField = {
        let arriveDistanceTextField = UITextField()
        arriveDistanceTextField.historyCustomTextField(placeholder: "ex) 17665", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 45, height: arriveDistanceTextField.frame.size.height)))
        arriveDistanceTextField.layer.borderWidth = 1.5
        arriveDistanceTextField.layer.cornerRadius = Constants.cornerRadius
        arriveDistanceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.tpDriveDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeArriveDistanceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        arriveDistanceTextField.inputAccessoryView = nextTextField
        
        return arriveDistanceTextField
    }()
    
    @objc func toTotalDistanceTextField() {
        self.totalDistanceTextField.becomeFirstResponder()
    }
    
    @objc func tpDriveDistanceTextField() {
        self.driveDistenceTextField.becomeFirstResponder()
    }
    
    @objc func closeArriveDistanceTextField() {
        self.arriveDistanceTextField.resignFirstResponder()
    }
    
    lazy var driveDistenceStackView: UIStackView = {
        let driveDistenceStackView = UIStackView(arrangedSubviews: [driveDistenceLabel, driveDistenceTextField])
        driveDistenceStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
        driveDistenceStackView.distribution = .fill
        return driveDistenceStackView
    }()
    
    lazy var driveDistenceLabel: UILabel = {
        let driveDistenceLabel = UILabel()
        driveDistenceLabel.customLabel(text: "주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return driveDistenceLabel
    }()
    
    lazy var driveDistenceTextField: UITextField = {
        let driveDistenceTextField = UITextField()
        driveDistenceTextField.historyCustomTextField(placeholder: "ex) 10", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: 45, height: driveDistenceTextField.frame.size.height)))
        driveDistenceTextField.layer.borderWidth = 1.5
        driveDistenceTextField.layer.cornerRadius = Constants.cornerRadius
        driveDistenceTextField.keyboardType = .decimalPad
        
        let nextTextField = UIToolbar()
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toArriveDistanceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeDriveDistenceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        driveDistenceTextField.inputAccessoryView = nextTextField
        
        return driveDistenceTextField
    }()
    
    @objc func closeDriveDistenceTextField() {
        self.driveDistenceTextField.resignFirstResponder()
    }
    
    //MARK: - 단위 Label
    lazy var kmLabel: UILabel = {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return kmLabel
    }()
    
    lazy var kmLabel2: UILabel = {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return kmLabel
    }()
    
    lazy var kmLabel3: UILabel = {
        let kmLabel = UILabel()
        kmLabel.customLabel(text: "km", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .center)
        return kmLabel
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
        saveButton.customButton(text: "수정", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium), titleColor: .mainNavyColor, backgroundColor: .buttonSkyBlueColor)
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
        addSubview(addDrivingPageLabel)
        addSubview(inputDrivingStackView)
        addSubview(buttonStackView)
        
        totalDistanceStackView.addSubview(kmLabel)
        arriveDistanceStackView.addSubview(kmLabel2)
        driveDistenceStackView.addSubview(kmLabel3)
        
        addDrivingPageLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        inputDrivingStackView.snp.makeConstraints { make in
            make.top.equalTo(addDrivingPageLabel.snp.bottom).offset(30)
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
        totalDistanceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        arriveDistanceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        driveDistenceLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
        }
        
        kmLabel.snp.makeConstraints { make in
            make.trailing.equalTo(totalDistanceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(totalDistanceStackView)
        }
        
        kmLabel2.snp.makeConstraints { make in
            make.trailing.equalTo(arriveDistanceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(arriveDistanceStackView)
        }
        
        kmLabel3.snp.makeConstraints { make in
            make.trailing.equalTo(driveDistenceStackView).offset(-Constants.horizontalMargin)
            make.centerY.equalTo(driveDistenceStackView)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(50)
        }
    }

}
