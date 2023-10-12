//
//  MyCarCheckViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class MyCarCheckViewController: UIViewController {
    private let checkEngineOilView = CheckingView(title: "엔진 오일은 언제 교체하셨나요?", firstButton: "6개월 전", secondButton: "3개월 전", thirdbutton: "1개월 전", fourthButton: "최근", fifthButton: "모르겠어요")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(checkEngineOilView)
        
        checkEngineOilView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
