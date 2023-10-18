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
        
        buttonActions()
        
    }
    
    func buttonActions() {
        addFuelingView.saveButton.addAction(UIAction(handler: { _ in
            print("---> addFuelingView 저장 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
        
        addFuelingView.cancelButton.addAction(UIAction(handler: { _ in
            print("---> addFuelingView 취소 버튼 클릭 했어요")
            self.dismiss(animated: true)
        }), for: .touchUpInside)
    }
    
}
