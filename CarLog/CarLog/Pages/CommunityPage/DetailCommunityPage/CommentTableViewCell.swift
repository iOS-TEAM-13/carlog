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
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.08.28"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .light)
        label.textColor = .black
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
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .medium)
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
            make.topMargin.equalToSuperview().offset(Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.verticalMargin - 4)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(userNameLabel.snp.bottom).offset(Constants.verticalMargin)
            make.bottomMargin.equalToSuperview().offset(-Constants.verticalMargin)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin + 1)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
        }
    }
    
    func configure(with userName: String, comment: String) {
        userNameLabel.text = userName
        commentLabel.text = comment
    }
}
