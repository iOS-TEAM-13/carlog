//
//  MyCarDetaiViewlCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/18.
//

import UIKit

import SnapKit

class MyCarDetialViewCell: UICollectionViewCell {
    // MARK: Properties

    private let replacedDateLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "날짜", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .left)
        return label
    }()
    
    private let replacedTypeLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "구분", textColor: .systemGray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium), alignment: .left)
        return label
    }()
    
    // MARK: LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Method

    private func setupUI() {
        contentView.addSubview(replacedTypeLabel)
        contentView.addSubview(replacedDateLabel)
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .buttonSkyBlueColor
        
        replacedDateLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView).inset(Constants.verticalMargin)
            $0.trailing.equalTo(replacedTypeLabel.snp.leading)
        }
        
        replacedTypeLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(contentView).inset(Constants.verticalMargin)
        }
    }
    
    func bind(date: String, type: String) {
        replacedDateLabel.text = date
        replacedTypeLabel.text = type
    }
}
