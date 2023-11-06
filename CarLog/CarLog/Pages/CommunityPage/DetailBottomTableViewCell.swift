//
//  DetailBottomTableViewCell.swift
//  CarLog
//
//  Created by 김은경 on 11/6/23.
//

import UIKit

import SnapKit

class DetailBottomTableViewCell: UITableViewCell {
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "빵빵이"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트 작성글"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var commentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, commentLabel])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .center)
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        addSubview(commentStackView)
        
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.verticalMargin)
            make.bottom.equalTo(self).offset(-Constants.verticalMargin)
        }
    }
    
    func configure(with userName: String, comment: String) {
        userNameLabel.text = userName
        commentLabel.text = comment
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
