//
//  VisionFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit
import SnapKit

class VisionFuelingViewController: UIViewController {
    
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
    }
    
    //MARK: - 비전 페이지 네비게이션바
    func navigationUI() {
        navigationItem.title = "사진으로 인식하기"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium),
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

    func visionFuelingButtonAction() {
        
    }

}
