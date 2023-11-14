//
//  CommentTableViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/3/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize14, weight: .bold)
        label.textColor = .black
        label.setContentHuggingPriority(.init(251), for: .horizontal)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.08.28"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .light)
        label.textColor = .black
        label.setContentHuggingPriority(.init(250), for: .horizontal)
        return label
    }()
    
    lazy var commentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, dateLabel])
        stackView.customStackView(spacing: Constants.horizontalMargin, axis: .horizontal, alignment: .center)
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize14, weight: .medium)
        label.numberOfLines = 5
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(commentStackView)
        contentView.addSubview(commentLabel)
        
        commentStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Constants.verticalMargin)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(commentStackView.snp.bottom).offset(Constants.verticalMargin)
            make.bottom.equalTo(contentView).offset(-Constants.verticalMargin)
            make.leading.equalTo(contentView).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView).offset(-Constants.horizontalMargin)
        }
    }
    
    func configure(with userName: String, comment: String) {
        userNameLabel.text = userName
        commentLabel.text = comment
    }
}
