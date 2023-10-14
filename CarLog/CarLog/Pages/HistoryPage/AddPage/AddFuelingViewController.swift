//
//  AddFuelingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddFuelingViewController: UIViewController {

    lazy var addFuelingView: AddFuelingView = {
        let addFuelingView = AddFuelingView()
        return addFuelingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        view.addSubview(addFuelingView)
        addFuelingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        addFuelingView.saveButton.addTarget(self, action: #selector(didSaveButton), for: .touchUpInside)
        addFuelingView.cancelButton.addTarget(self, action: #selector(didCancelButton), for: .touchUpInside)
        
    }
    
    @objc func didSaveButton() {
        print("---> addFuelingPage 저장 버튼 눌렀어요")
        dismiss(animated: true)
    }
    
    @objc func didCancelButton() {
        print("---> addFuelingPage 취소 버튼 눌렀어요")
        dismiss(animated: true)
    }
    
    
    
    
}
