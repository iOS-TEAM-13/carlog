//
//  VisionDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit
import Vision

class VisionDrivingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var visionDrivingView: VisionDrivingView = {
        let visionDrivingView = VisionDrivingView()
        return visionDrivingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(visionDrivingView)
        visionDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationUI()
        
        visionDrivingButtonAction()
    }
    
    //빈 화면 클릭 시 키보드 내리는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        visionDrivingView.endEditing(true)
    }
    
    //MARK: - 주행 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToAddDrivingPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToAddDrivingPage() {
        print("비전 페이지에서 주유 추가 페이지로 뒤로간다")
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionDrivingButtonAction() {
        visionDrivingView.visionDepartImageButton.addAction(UIAction(handler: { _ in
            print("계기판 사진을 추가해봅시다")
        }), for: .touchUpInside)
    }
    
}
