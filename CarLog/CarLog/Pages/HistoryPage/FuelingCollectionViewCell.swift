//
//  FuelingCollectionViewCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/17.
//

import SnapKit
import UIKit

class FuelingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FuelingCollectionViewCell"
    
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [cellTopLabelStackView, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var cellTopLabelStackView: UIStackView = {
        let cellTopLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, priceLabel])
        cellTopLabelStackView.axis = .horizontal
        cellTopLabelStackView.distribution = .equalSpacing
        cellTopLabelStackView.alignment = .top
        return cellTopLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = Constants.fontJua16 ?? UIFont()
        return writeDateLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .black
        priceLabel.font = Constants.fontJua20 ?? UIFont()
        return priceLabel
    }()
    
    lazy var cellBottomLabelStackView: UIStackView = {
        let cellBottomLabelStackView = UIStackView(arrangedSubviews: [totalPriceLabel, countLabel])
        cellBottomLabelStackView.axis = .horizontal
        cellBottomLabelStackView.distribution = .equalSpacing
        cellBottomLabelStackView.alignment = .bottom
        return cellBottomLabelStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.textColor = .black
        totalPriceLabel.font = Constants.fontJua32 ?? UIFont()
        return totalPriceLabel
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.textColor = .black
        countLabel.font = Constants.fontJua20 ?? UIFont()
        return countLabel
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
