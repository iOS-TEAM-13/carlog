//
//  AddDrivingViewController.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddDrivingViewController: UIViewController {
    
    lazy var dtitle: UILabel = {
        let dtitle = UILabel()
        dtitle.font = .systemFont(ofSize: 20, weight: .regular)
        dtitle.text = "주행기록 등록 페이지"
        return dtitle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        view.addSubview(dtitle)
        dtitle.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    

}
