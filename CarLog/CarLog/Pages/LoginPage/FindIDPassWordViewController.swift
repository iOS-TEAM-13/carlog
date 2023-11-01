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
        addTarget() // Call addTarget to set up the action for the segmented control.
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(findIDPassWordView.segmentedControl)
        view.addSubview(findIDPassWordView.findIDView)
        view.addSubview(findIDPassWordView.reSettingPasswordView)
        
        findIDPassWordView.segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(60)
        }
        
        findIDPassWordView.findIDView.snp.makeConstraints { make in
            make.top.equalTo(findIDPassWordView.segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        findIDPassWordView.reSettingPasswordView.snp.makeConstraints { make in
            make.top.equalTo(findIDPassWordView.segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
    
    private func addTarget() {
        findIDPassWordView.segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        findIDPassWordView.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
}
