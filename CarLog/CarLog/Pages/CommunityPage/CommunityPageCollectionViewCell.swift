//
//  communityPageCollectionViewCell.swift
//  CarLog
//
//  Created by t2023-m0075 on 10/30/23.
//

import UIKit

class CommunityPageCollectionViewCell: UICollectionViewCell {
    
    private let userProfile: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "rocket") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "사용자 이름"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    private let spanerImage: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "spaner") {
            imageView.image = image
        }
        return imageView
       
    }()
    
    private let commentImage: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "comment") {
            imageView.image = image
        }
        return imageView
    }()
    
    private let spanerCounts: UILabel = {
        let label = UILabel()
        label.text = "27"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    private let commentCounts: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    private let collectionViewImage: UIImageView = {
        let imageView = UIImageView()
        if let image = UIImage(named: "sample2") {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        return label
    }()
    
    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "본문"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }
    
    private func  setupUI() {
        contentView.addSubview(userProfile)
        contentView.addSubview(userName)
        contentView.addSubview(spanerImage)
        contentView.addSubview(commentImage)
        contentView.addSubview(spanerCounts)
        contentView.addSubview(commentCounts)
        contentView.addSubview(collectionViewImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(mainTextLabel)
        contentView.backgroundColor = .buttonSkyBlueColor
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        userProfile.snp.makeConstraints { make in
            make.width.equalTo(31)
            make.height.equalTo(32)
            make.leftMargin.equalToSuperview().offset(16)
            make.topMargin.equalToSuperview().offset(14)
        }
        
        userName.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(60)
            make.topMargin.equalToSuperview().offset(23)
        }
        
        spanerImage.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.leftMargin.equalToSuperview().offset(258)
            make.topMargin.equalToSuperview().offset(19)
        }
        
        spanerCounts.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(280)
            make.topMargin.equalToSuperview().offset(21)
        }
        
        commentImage.snp.makeConstraints { make in
            make.width.height.equalTo(17)
            make.leftMargin.equalToSuperview().offset(310)
            make.topMargin.equalToSuperview().offset(19)
        }
        
        commentCounts.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(332)
            make.topMargin.equalToSuperview().offset(21)
        }
        
        collectionViewImage.snp.makeConstraints { make in
            make.width.equalTo(329)
            make.height.equalTo(168)
            make.leftMargin.equalToSuperview().offset(12)
            make.topMargin.equalToSuperview().offset(57)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(19)
            make.topMargin.equalToSuperview().offset(236)
        }
        
        mainTextLabel.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(19)
            make.topMargin.equalToSuperview().offset(271)
        }
    }
    
}
