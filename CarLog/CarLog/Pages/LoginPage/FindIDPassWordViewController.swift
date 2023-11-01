//
//  FindIDPassWordViewController.swift
//  CarLog
//
//  Created by 김은경 on 10/31/23.
//
import UIKit

import SnapKit

class FindIDPassWordViewController: UIViewController {
    let findView = FindIDPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        addTarget() // Call addTarget to set up the action for the segmented control.
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(findView.segmentedControl)
        view.addSubview(findView.findIDView)
        view.addSubview(findView.reSettingPasswordView)
        findView.reSettingPasswordView.addSubview(findView.emailTextField)
        findView.reSettingPasswordView.addSubview(findView.buttonStackView)
        
        findView.segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(60)
        }
        
        findView.findIDView.snp.makeConstraints { make in
            make.top.equalTo(findView.segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        findView.reSettingPasswordView.snp.makeConstraints { make in
            make.top.equalTo(findView.segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        findView.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(findView.reSettingPasswordView.snp.top).offset(Constants.verticalMargin)
            make.leading.equalTo(findView.reSettingPasswordView.snp.leading).offset(Constants.verticalMargin)
            make.trailing.equalTo(findView.reSettingPasswordView.snp.trailing).offset(-Constants.verticalMargin)
        }
        
        findView.buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(findView.reSettingPasswordView.snp.bottom).offset(-Constants.verticalMargin)
            make.leading.equalTo(findView.reSettingPasswordView.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(findView.reSettingPasswordView.snp.trailing).offset(-Constants.horizontalMargin)
        }
    }
    
    private func addTarget() {
        findView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        findView.sendButton.addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
        
        findView.popButton.addAction(UIAction(handler: { _ in
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
    @objc private func sendEmailTapped() {
        
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        findView.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
