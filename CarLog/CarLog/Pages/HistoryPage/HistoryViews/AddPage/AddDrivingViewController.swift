//
//  AddDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddDrivingViewController: UIViewController {
    
    lazy var addDrivingView: AddDrivingView = {
        let addDrivingView = AddDrivingView()
        return addDrivingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        view.addSubview(addDrivingView)
        addDrivingView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        buttonActions()
        
    }
    
    func buttonActions() {
        addDrivingView.saveButton.addAction(UIAction(handler: { _ in
            print("---> addDrivingView 저장 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        addDrivingView.cancelButton.addAction(UIAction(handler: { _ in
            print("---> addDrivingView 취소 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
}
