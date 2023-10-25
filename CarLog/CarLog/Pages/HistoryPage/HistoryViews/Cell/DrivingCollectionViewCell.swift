//
//  DrivingCollectionViewCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/16.
//

import SnapKit
import UIKit

class DrivingCollectionViewCell: UICollectionViewCell {
    
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return writeDateLabel
    }()
    
    lazy var cellBottomLabelStackView: UIStackView = {
        let cellBottomLabelStackView = UIStackView(arrangedSubviews: [driveDistenceLabel, arriveTotalDistenceLabel])
        cellBottomLabelStackView.axis = .horizontal
        cellBottomLabelStackView.distribution = .equalSpacing
        cellBottomLabelStackView.alignment = .bottom
        return cellBottomLabelStackView
    }()
    
    lazy var driveDistenceLabel: UILabel = {
        let driveDistenceLabel = UILabel()
        driveDistenceLabel.textColor = .black
        driveDistenceLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua32, weight: .medium)
        return driveDistenceLabel
    }()
    
    lazy var arriveTotalDistenceLabel: UILabel = {
        let arriveTotalDistenceLabel = UILabel()
        arriveTotalDistenceLabel.textColor = .black
        arriveTotalDistenceLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return arriveTotalDistenceLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    func setupUI() {
        contentView.addSubview(cellLabelStackView)
        
        cellLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
    }
    
}
