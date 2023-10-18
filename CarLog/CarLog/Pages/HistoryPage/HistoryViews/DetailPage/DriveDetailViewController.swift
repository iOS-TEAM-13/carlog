//
//  DriveDetailViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/18.
// 취소 수정버튼 히든처리 , 네비게이션바 아이템 수정 버튼 추가

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
        print("---> driveDetailView 수정 버튼 눌렀어요")
//        navigationController?.pushViewController(HistoryPageViewController(), animated: true)
        
        
    }
    
    @objc func didCancelButton() {
        print("---> driveDetailView 취소 버튼 눌렀어요")
//        navigationController?.pushViewController(HistoryPageViewController(), animated: true)
    }
    
}
