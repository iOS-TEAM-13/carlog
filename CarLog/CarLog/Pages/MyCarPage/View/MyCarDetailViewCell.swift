//
//  MyCarDetaiViewlCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/18.
//

import SnapKit
import UIKit

class MyCarDetialViewCell: UICollectionViewCell {
    private let replacedDateLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "날짜", textColor: .black, font: Constants.fontJua20 ?? UIFont.systemFont(ofSize: 20), alignment: .left)
        return label
    }()
    
    private let replacedTypeLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "구분", textColor: .systemGray, font: Constants.fontJua16 ?? UIFont.systemFont(ofSize: 16), alignment: .left)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(replacedTypeLabel)
        contentView.addSubview(replacedDateLabel)
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .thirdColor
        
        replacedDateLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView).inset(Constants.verticalMargin)
            $0.trailing.equalTo(replacedTypeLabel.snp.leading)
        }
        
        replacedTypeLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(contentView).inset(Constants.verticalMargin)
//            $0.leading.equalTo(replacedDateLabel.snp.trailing)
        }
    }
    
    func bind(date: String, type: String) {
        self.replacedDateLabel.text = date
        self.replacedTypeLabel.text = type
    }
}
