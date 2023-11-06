//
//  DriveDetailView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.
//

import UIKit
import SnapKit

class DrivingDetailView: UIView {
    
//MARK: - 주행 기록 페이지 전체 스택뷰
    lazy var inputDrivingStackView: UIStackView = {
        let inputDrivingStackView = UIStackView(arrangedSubviews: [drivingPurposeStackView, totalDistanceStackView, arriveDistanceStackView, driveDistenceStackView])
        inputDrivingStackView.customStackView(spacing: 20, axis: .vertical, alignment: .center)
        inputDrivingStackView.backgroundColor = .white
        inputDrivingStackView.layer.cornerRadius = Constants.cornerRadius
        return inputDrivingStackView
    }()
    
//MARK: - 운행 목적 영역 (추가)
    lazy var drivingPurposeStackView: UIStackView = {
        let drivingPurposeStackView = UIStackView(arrangedSubviews: [drivingPurposeLabel, drivingPurposeTextField])
        drivingPurposeStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        drivingPurposeStackView.distribution = .fill
        return drivingPurposeStackView
    }()
    
    lazy var drivingPurposeLabel: UILabel = {
        let drivingPurposeLabel = UILabel()
        drivingPurposeLabel.customLabel(text: "운행 목적 (15자)", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return drivingPurposeLabel
    }()
    
    lazy var drivingPurposeTextField: UITextField = {
        let drivingPurposeTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        drivingPurposeTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 드라이브, 출퇴근", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: Constants.horizontalMargin, height: drivingPurposeTextField.frame.size.height)), keyboardType: .decimalPad)
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toDriveDistanceTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeDrivingPurposeTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        drivingPurposeTextField.inputAccessoryView = nextTextField
        
        return drivingPurposeTextField
    }()
    
    @objc func toDriveDistanceTextField() {
        driveDistenceTextField.becomeFirstResponder()
    }
    
    @objc func toTotalDistanceTextField() {
        totalDistanceTextField.becomeFirstResponder()
    }
    
    @objc func closeDrivingPurposeTextField() {
        drivingPurposeTextField.resignFirstResponder()
    }
        
//MARK: - 누적(출발) 주행거리 영역
    lazy var totalDistanceStackView: UIStackView = {
        let totalDistanceStackView = UIStackView(arrangedSubviews: [totalDistanceLabel, totalDistanceTextField])
        totalDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
        totalDistanceStackView.distribution = .fill
        return totalDistanceStackView
    }()
    
    lazy var totalDistanceLabel: UILabel = {
        let totalDistanceLabel = UILabel()
        totalDistanceLabel.customLabel(text: "누적(출발) 주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
        return totalDistanceLabel
    }()
    
    //totalDistanceTextField, totalDistanceAddButton 스택뷰
//    lazy var totalTextFieldAddButtonStackView: UIStackView = {
//        let totalTextFieldaddButtonStackView = UIStackView(arrangedSubviews: [totalDistanceTextField, totalDistanceAddButton])
//        totalTextFieldaddButtonStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
//        return totalTextFieldaddButtonStackView
//    }()
    
    lazy var totalDistanceTextField: UITextField = {
        let totalDistanceTextField = UITextField()
        
        //customTextField 수정
        let placeholderColor: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
        ]
        
        totalDistanceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10000", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: drivingPurposeTextField.frame.size.height)), keyboardType: .decimalPad)

        totalDistanceTextField.rightView?.addSubview(UILabel.kmUnitLabel())
        
        let nextTextField = UIToolbar()
        nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        nextTextField.barStyle = UIBarStyle.default
        nextTextField.isTranslucent = true
        nextTextField.sizeToFit()
        
        let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toDrivingPurposeTextField))
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toArriveDistanceTextField))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeTotalDistanceTextField))
        
        nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
        nextTextField.isUserInteractionEnabled = true
        totalDistanceTextField.inputAccessoryView = nextTextField
        
        return totalDistanceTextField
    }()
    
    @objc func toDrivingPurposeTextField() {
        drivingPurposeTextField.becomeFirstResponder()
    }
    
    @objc func toArriveDistanceTextField() {
        arriveDistanceTextField.becomeFirstResponder()
    }
    
    @objc func closeTotalDistanceTextField() {
        totalDistanceTextField.resignFirstResponder()
    }
    
    //totalDistanceAddButton
//    lazy var totalDistanceAddButton: UIButton = {
//        let totalDistanceAddButton = UIButton()
//        var config = UIButton.Configuration.filled()
//        config.cornerStyle = .medium
//        config.baseBackgroundColor = .mainNavyColor
//        config.image = UIImage(systemName: "photo")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
//        totalDistanceAddButton.configuration = config
//        return totalDistanceAddButton
//    }()
    
    //MARK: - 도착 주행거리 영역
        lazy var arriveDistanceStackView: UIStackView = {
            let arriveDistanceStackView = UIStackView(arrangedSubviews: [arriveDistanceLabel, arriveDistanceTextField])
            arriveDistanceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
            arriveDistanceStackView.distribution = .fill
            return arriveDistanceStackView
        }()
        
        lazy var arriveDistanceLabel: UILabel = {
            let arriveDistanceLabel = UILabel()
            arriveDistanceLabel.customLabel(text: "도착 주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
            return arriveDistanceLabel
        }()
        
        //arriveDistanceTextField, arriveDistanceAddButton 스택뷰
    //    lazy var arriveTextFieldAddButtonStackView: UIStackView = {
    //        let arriveTextFieldAddButtonStackView = UIStackView(arrangedSubviews: [arriveDistanceTextField, arriveDistanceAddButton])
    //        arriveTextFieldAddButtonStackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .fill)
    //        return arriveTextFieldAddButtonStackView
    //    }()
        
        lazy var arriveDistanceTextField: UITextField = {
            let arriveDistanceTextField = UITextField()
            
            //customTextField 수정
            let placeholderColor: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.systemGray,
                .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
            ]
            
            arriveDistanceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10010", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: drivingPurposeTextField.frame.size.height)), keyboardType: .decimalPad)

            arriveDistanceTextField.rightView?.addSubview(UILabel.kmUnitLabel())
            
            let nextTextField = UIToolbar()
            nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
            nextTextField.barStyle = UIBarStyle.default
            nextTextField.isTranslucent = true
            nextTextField.sizeToFit()
            
            let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toTotalDistanceTextField))
            let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toDriveDistanceTextField))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeArriveDistanceTextField))
            
            nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
            nextTextField.isUserInteractionEnabled = true
            arriveDistanceTextField.inputAccessoryView = nextTextField
            
            return arriveDistanceTextField
        }()
        
        @objc func closeArriveDistanceTextField() {
            arriveDistanceTextField.resignFirstResponder()
        }
        
        //arriveDistanceAddButton
    //    lazy var arriveDistanceAddButton: UIButton = {
    //        let arriveDistanceAddButton = UIButton()
    //        var config = UIButton.Configuration.filled()
    //        config.cornerStyle = .medium
    //        config.baseBackgroundColor = .mainNavyColor
    //        config.image = UIImage(systemName: "photo")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
    //        arriveDistanceAddButton.configuration = config
    //        return arriveDistanceAddButton
    //    }()
        
    //MARK: - 주행거리 영역
        lazy var driveDistenceStackView: UIStackView = {
            let driveDistenceStackView = UIStackView(arrangedSubviews: [driveDistenceLabel, driveDistenceTextField])
            driveDistenceStackView.customStackView(spacing: Constants.verticalMargin, axis: .vertical, alignment: .fill)
            driveDistenceStackView.distribution = .fill
            return driveDistenceStackView
        }()
        
        lazy var driveDistenceLabel: UILabel = {
            let driveDistenceLabel = UILabel()
            driveDistenceLabel.customLabel(text: "주행거리", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .left)
            return driveDistenceLabel
        }()
        
        lazy var driveDistenceTextField: UITextField = {
            let driveDistenceTextField = UITextField()
            
            //customTextField 수정
            let placeholderColor: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.systemGray,
                .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium),
            ]
            
            driveDistenceTextField.historyNewCustomTextField(placeholder: NSAttributedString(string: "ex) 10", attributes: placeholderColor), font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), textColor: .black, alignment: .right, paddingView: UIView(frame: CGRect(x: 0, y: 0, width: UILabel.kmUnitLabel().intrinsicContentSize.width + Constants.horizontalMargin, height: drivingPurposeTextField.frame.size.height)), keyboardType: .decimalPad)

            driveDistenceTextField.rightView?.addSubview(UILabel.kmUnitLabel())
            
            let nextTextField = UIToolbar()
            nextTextField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
            nextTextField.barStyle = UIBarStyle.default
            nextTextField.isTranslucent = true
            nextTextField.sizeToFit()
            
            let beforeButton = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(self.toArriveDistanceTextField))
            let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(self.toDrivingPurposeTextField))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let closeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.closeDriveDistenceTextField))
            
            nextTextField.setItems([beforeButton, nextButton, flexibleSpace, closeButton], animated: false)
            nextTextField.isUserInteractionEnabled = true
            driveDistenceTextField.inputAccessoryView = nextTextField
            
            return driveDistenceTextField
        }()
        
        @objc func closeDriveDistenceTextField() {
            driveDistenceTextField.resignFirstResponder()
        }
        
    // MARK: - 삭제, 수정 버튼 영역
        lazy var buttonStackView: UIStackView = {
            let buttonStackView = UIStackView(arrangedSubviews: [removeButton, upDateButton])
            buttonStackView.customStackView(spacing: 60, axis: .horizontal, alignment: .fill)
            buttonStackView.distribution = .fillEqually
            return buttonStackView
        }()
        
        lazy var upDateButton: UIButton = {
            let upDateButton = UIButton()
            upDateButton.customButton(text: "수정", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
            upDateButton.layer.cornerRadius = Constants.cornerRadius
            return upDateButton
        }()
        
        lazy var removeButton: UIButton = {
            let removeButton = UIButton()
            removeButton.customButton(text: "삭제", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
            removeButton.layer.cornerRadius = Constants.cornerRadius
            return removeButton
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
            addSubview(inputDrivingStackView)
            addSubview(buttonStackView)
            
            inputDrivingStackView.snp.makeConstraints { make in
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(Constants.horizontalMargin)
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(Constants.horizontalMargin)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-Constants.horizontalMargin)
            }
            
            drivingPurposeStackView.snp.makeConstraints { make in
                make.top.equalTo(inputDrivingStackView.snp.top).offset(Constants.horizontalMargin * 2)
                make.leading.equalTo(inputDrivingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
                make.trailing.equalTo(inputDrivingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
            }
            
            totalDistanceStackView.snp.makeConstraints { make in
                make.top.equalTo(drivingPurposeStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
                make.leading.equalTo(inputDrivingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
                make.trailing.equalTo(inputDrivingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
            }
            
            arriveDistanceStackView.snp.makeConstraints { make in
                make.top.equalTo(totalDistanceStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
                make.leading.equalTo(inputDrivingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
                make.trailing.equalTo(inputDrivingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
            }

            driveDistenceStackView.snp.makeConstraints { make in
                make.top.equalTo(arriveDistanceStackView.snp.bottom).offset(Constants.horizontalMargin * 2)
                make.leading.equalTo(inputDrivingStackView.snp.leading).offset(Constants.horizontalMargin * 2)
                make.trailing.equalTo(inputDrivingStackView.snp.trailing).offset(-Constants.horizontalMargin * 2)
                make.bottom.equalTo(inputDrivingStackView.snp.bottom).offset(-Constants.horizontalMargin * 2)
            }
            
            driveDistenceTextField.snp.makeConstraints { make in
                make.bottom.equalTo(inputDrivingStackView.snp.bottom).offset(-Constants.horizontalMargin * 2)
            }
            
            buttonStackView.snp.makeConstraints { make in
                make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalMargin)
                make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-40)
                make.height.equalTo(50)
            }
        }
    }
