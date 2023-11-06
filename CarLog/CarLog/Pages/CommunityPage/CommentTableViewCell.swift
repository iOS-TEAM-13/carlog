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
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
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

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
