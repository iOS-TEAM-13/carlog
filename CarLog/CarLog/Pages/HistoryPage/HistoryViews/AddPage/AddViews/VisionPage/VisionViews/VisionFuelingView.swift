//
//  VisionFuelingView.swift
//  CarLog
//
//  Created by 김지훈 on 11/9/23.
//

import UIKit

class VisionFuelingView: UIView {

    lazy var addvisionStackView: UIStackView = {
        let visionStackView = UIStackView(arrangedSubviews: [addVisionLabel, addVisionButton])
        visionStackView.customStackView(spacing: 30, axis: .vertical, alignment: .center)
        return visionStackView
    }()
    
    lazy var addVisionLabel: UILabel = {
        let addVisionLabel = UILabel()
        addVisionLabel.customLabel(text: "영수증을 선택해주세요.", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), alignment: .center)
        return addVisionLabel
    }()
    
    lazy var addVisionButton: UIButton = {
        let addVisionButton = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .mainNavyColor
        config.image = UIImage(systemName: "plus")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 80, weight: .medium))
        addVisionButton.configuration = config
        return addVisionButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - addVisionFueling UI 설정
    private func setupUI() {
        addSubview(addvisionStackView)
        
        addvisionStackView.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        addVisionButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
    }
}
