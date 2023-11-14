//
//  DatePickerView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class DatePickerView: UIView {
    // MARK: Properties
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        return picker
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .mainNavyColor
        return button
    }()
    
    // MARK: LifeCycle
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method
    private func setupUI() {
        addSubview(datePicker)
        addSubview(completeButton)
        
        datePicker.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self).inset(Constants.horizontalMargin)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).inset(Constants.verticalMargin)
            $0.centerX.equalTo(self)
            $0.width.equalTo(200)
        }
        if traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = .mainNavyColor
        } else {
            self.backgroundColor = .buttonSkyBlueColor
        }
    }
}
