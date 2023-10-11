//
//  MyPageTableViewCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import UIKit
import SnapKit

class MyCarTableViewCell: UITableViewCell {
    static var identifier = "MyCarTableViewCell"
    
    private var tableViewImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private var tableViewTitle: UILabel = {
        var label = UILabel()
        label.customLabel(text: "이름", textColor: .black, font: Constants.fontJua16 ?? UIFont.systemFont(ofSize: 16), alignment: .left)
        return label
    }()

    lazy private var progressView: UIProgressView = {
        let view = UIProgressView()
        /// progress 배경 색상
        view.trackTintColor = .lightGray
        /// progress 진행 색상
        view.progressTintColor = .systemBlue
        view.progress = 0.1
        return view
    }()
    
    private var tableViewPeriod: UILabel = {
        var label = UILabel()
        label.customLabel(text: "기간", textColor: .systemGray, font: Constants.fontJua10 ?? UIFont.systemFont(ofSize: 10), alignment: .left)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        contentView.addSubview(tableViewImage)
        contentView.addSubview(tableViewTitle)
        contentView.addSubview(progressView)
        contentView.addSubview(tableViewPeriod)
        
        tableViewImage.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView)
            $0.width.height.equalTo(80)
        }
        
        tableViewTitle.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView).inset(Constants.verticalMargin)
            $0.leading.equalTo(tableViewImage.snp.trailing).inset(-Constants.horizontalMargin)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(tableViewTitle.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(tableViewImage.snp.trailing).inset(-Constants.horizontalMargin)
        }
        
        tableViewPeriod.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(tableViewImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.bottom.trailing.equalTo(contentView).inset(Constants.verticalMargin)
        }
    }
    
    func bind(text: String, period: String) {
        tableViewTitle.text = text
        tableViewPeriod.text = period
    }

}
