//
//  DrivingCollectionViewCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/16.
//

import SnapKit
import UIKit

class DrivingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DrivingCollectionViewCell"
    
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = Constants.fontJua14 ?? UIFont()
        return writeDateLabel
    }()
    
    lazy var cellBottomLabelStackView: UIStackView = {
        let cellBottomLabelStackView = UIStackView(arrangedSubviews: [driveDistenceLabel, departDistenceLabel])
        cellBottomLabelStackView.axis = .horizontal
        cellBottomLabelStackView.distribution = .equalSpacing
        cellBottomLabelStackView.alignment = .center
        return cellBottomLabelStackView
    }()
    
    lazy var driveDistenceLabel: UILabel = {
        let driveDistenceLabel = UILabel()
        driveDistenceLabel.textColor = .black
        driveDistenceLabel.font = Constants.fontJua28 ?? UIFont()
        return driveDistenceLabel
    }()
    
    lazy var departDistenceLabel: UILabel = {
        let departDistenceLabel = UILabel()
        departDistenceLabel.textColor = .black
        departDistenceLabel.font = Constants.fontJua20 ?? UIFont()
        return departDistenceLabel
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
