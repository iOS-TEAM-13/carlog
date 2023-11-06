//
//  DrivingCollectionViewCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/16.
//

import UIKit
import SnapKit

class DrivingCollectionViewCell: UICollectionViewCell {
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [cellTopLabelStackView, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var cellTopLabelStackView: UIStackView = {
        let cellTopLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, drivingPurposeLabel])
        cellTopLabelStackView.axis = .horizontal
        cellTopLabelStackView.spacing = 50
        cellTopLabelStackView.distribution = .equalSpacing
        cellTopLabelStackView.alignment = .top
        return cellTopLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return writeDateLabel
    }()
    
    lazy var drivingPurposeLabel: UILabel = {
        let drivingPurposeLabel = UILabel()
        drivingPurposeLabel.textColor = .darkGray
        drivingPurposeLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        drivingPurposeLabel.numberOfLines = 1
        return drivingPurposeLabel
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
        arriveTotalDistenceLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium)
        return arriveTotalDistenceLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
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
