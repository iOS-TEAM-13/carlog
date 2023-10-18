//
//  DriveDetailViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.
//

import UIKit

class DriveDetailViewController: UIViewController {
    
    lazy var driveDetailView: DriveDetailView = {
        let driveDetailView = DriveDetailView()
        return driveDetailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(driveDetailView)
        driveDetailView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        driveDetailView.saveButton.addTarget(self, action: #selector(didSaveButton), for: .touchUpInside)
        driveDetailView.cancelButton.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        
    }
    
    @objc func didSaveButton() {
        print("---> addDrivingView 저장 버튼 눌렀어요")
        dismiss(animated: true)
    }
    
    @objc func didCancelButton() {
        print("---> addDrivingView 취소 버튼 눌렀어요")
        dismiss(animated: true)
    }
    
}
