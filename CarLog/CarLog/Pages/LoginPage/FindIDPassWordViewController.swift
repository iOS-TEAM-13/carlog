//
//  FindIDPassWordViewController.swift
//  CarLog
//
//  Created by 김은경 on 10/31/23.
//

import UIKit

import SnapKit

class FindIDPassWordViewController: UIViewController {
    let findIDPassWordView = FindIDPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(findIDPassWordView.segmentedControl)
        view.addSubview(findIDPassWordView.emailTextField)
        
        findIDPassWordView.segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(60)
        }
        
        findIDPassWordView.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(findIDPassWordView.segmentedControl.snp.bottom).offset(Constants.verticalMargin * 2)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
    }
    
    private func addTarget() {
        findIDPassWordView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
    }

    @objc private func didChangeValue(segment: UISegmentedControl) {
        findIDPassWordView.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }

}
