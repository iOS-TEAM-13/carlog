//
//  AddDrivingView.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/13.
//

import SnapKit
import UIKit

class AddDrivingView: UIView {

    lazy var oliTypeLabel: UILabel = {
        let oliTypeLabel = UILabel()
        oliTypeLabel.customLabel(text: "주행 기록", textColor: .black, font: Constants.fontJua28 ?? UIFont(), alignment: .center)
        return oliTypeLabel
    }()
    
    lazy var addPhotoButton: UIButton = {
        let addPhotoButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "photo")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        addPhotoButton.configuration = config
        addPhotoButton.backgroundColor = .primaryColor
        addPhotoButton.layer.cornerRadius = 10
        return addPhotoButton
    }()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
    }

}
