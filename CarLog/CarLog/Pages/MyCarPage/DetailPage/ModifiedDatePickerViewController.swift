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
    private let datePickerView = DatePickerView()
    
    var onDateSelected: ((Date) -> Void)?
    
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
        view.addSubview(datePickerView)
        
        datePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func buttonActions() {
        datePickerView.completeButton.addAction(UIAction(handler: { _ in self.completeButtonTapped() }), for: .touchUpInside)
    }

    private func completeButtonTapped() {
        let selectedDate = datePickerView.datePicker.date
        onDateSelected?(selectedDate)
        
        dismiss(animated: true, completion: nil)
    }
}
