//
//  VisionFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import MobileCoreServices
import SnapKit
import Vision

class VisionFuelingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var visionFuelingView: VisionFuelingView = {
        let visionFuelingView = VisionFuelingView()
        return visionFuelingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        
        view.addSubview(visionFuelingView)
        visionFuelingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationUI()
        
        visionFuelingButtonAction()
    }
    
    //빈 화면 클릭 시 키보드 내리는 코드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        visionFuelingView.endEditing(true)
    }
    
    //MARK: - 주유 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize16, weight: .medium),
            .foregroundColor: UIColor.mainNavyColor
        ]
        
        self.navigationItem.leftBarButtonItem = self.backButton
    }
    
    lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goToAddFuelingPage))
        backButton.tintColor = .mainNavyColor
        return backButton
    }()
    
    @objc func goToAddFuelingPage() {
        print("비전 페이지에서 주유 추가 페이지로 뒤로간다")
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - VisionFuelingView addImage 버튼 액션
    func visionFuelingButtonAction() {
        
    }
    
    
 }
