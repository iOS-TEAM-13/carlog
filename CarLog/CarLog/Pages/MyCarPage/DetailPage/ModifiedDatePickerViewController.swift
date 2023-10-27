//
//  ModifiedDatePickerViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/24.
//

import UIKit

import SnapKit

class ModifiedDatePickerViewController: UIViewController {
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
    
    var onDateSelected: ((String) -> Void)?
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
        }
        
        setupUI()
        buttonActions()
    }
    
    // MARK: Method

    private func setupUI() {
        view.addSubview(datePicker)
        view.addSubview(completeButton)
        
        datePicker.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).inset(Constants.verticalMargin)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .mainNavyColor
        } else {
            view.backgroundColor = .buttonSkyBlueColor
        }
    }
    
    private func buttonActions() {
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: @Objc

    @objc func completeButtonTapped() {
        let selectedDate = datePicker.date.toString()
        onDateSelected?(selectedDate)
        dismiss(animated: true, completion: nil)
    }
}
