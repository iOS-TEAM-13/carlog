//
//  MyCarDetailPageView.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/11/14.
//

import UIKit

import SnapKit

class MyCarDetailPageView: UIView {
    var selectedTitleLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "이름", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), alignment: .left)
        return label
    }()
    
    lazy var selectedprogressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .buttonSkyBlueColor
        view.progressTintColor = .mainNavyColor
        view.progress = 0.1
        return view
    }()
    
    var selectedIntervalLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "기간", textColor: .systemGray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .medium), alignment: .left)
        return label
    }()
    
    let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.forward")
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        
        addSubview(selectedImageView)
        addSubview(selectedTitleLabel)
        addSubview(selectedprogressView)
        addSubview(selectedIntervalLabel)
        
        selectedImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(self).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(60)
            $0.centerY.equalTo(self)
        }
        
        selectedTitleLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(self).inset(Constants.horizontalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.verticalMargin)
        }
        
        selectedprogressView.snp.makeConstraints {
            $0.top.equalTo(selectedTitleLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(self).inset(Constants.horizontalMargin)
            $0.height.equalTo(4)
        }
        
        selectedIntervalLabel.snp.makeConstraints {
            $0.top.equalTo(selectedprogressView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(self).inset(Constants.horizontalMargin)
            $0.bottom.equalTo(self).inset(Constants.verticalMargin)
        }
    }
}
