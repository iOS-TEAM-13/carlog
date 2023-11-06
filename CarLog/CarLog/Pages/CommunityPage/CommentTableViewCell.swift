//
//  CommentTableViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/3/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.numberOfLines = 0
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
        contentView.addSubview(userNameLabel)
        contentView.addSubview(commentLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.equalToSuperview().offset(16)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.bottomMargin.equalToSuperview().offset(-12)
            make.left.equalTo(userNameLabel.snp.right).offset(16)
            make.rightMargin.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with userName: String, comment: String) {
        userNameLabel.text = userName
        commentLabel.text = comment
    }
}
