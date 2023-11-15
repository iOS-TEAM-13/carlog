//
//  MyPageSettingView.swift
//  CarLog
//
//  Created by APPLE M1 Max on 11/14/23.
//

import UIKit

import SnapKit

class MyPageSettingView: UIView {

    // MARK: - Proprties
    
    lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize14, weight: .regular),
            .foregroundColor: UIColor.lightGray,
        ]
        let attributedTitle = NSAttributedString(string: "로그아웃", attributes: attributes)
        logoutButton.setAttributedTitle(attributedTitle, for: .normal)
        logoutButton.backgroundColor = .clear
        return logoutButton
    }()
    
    lazy var horizontalDivider: UIView = {
        let horizontalDivider = UIView()
        horizontalDivider.widthAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalDivider.heightAnchor.constraint(equalToConstant: 15).isActive = true
        horizontalDivider.backgroundColor = .lightGray
        return horizontalDivider
    }()
    
    lazy var quitUserButton: UIButton = {
        let quitUserButton = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.spoqaHanSansNeo(size: Constants.fontSize14, weight: .regular),
            .foregroundColor: UIColor.lightGray,
        ]
        let attributedTitle = NSAttributedString(string: "회원탈퇴", attributes: attributes)
        quitUserButton.setAttributedTitle(attributedTitle, for: .normal)
        quitUserButton.backgroundColor = .clear
        return quitUserButton
    }()
    
    lazy var myPageDesignStackView = {
        let myPageDesignStackView = UIStackView(arrangedSubviews: [logoutButton, horizontalDivider, quitUserButton])
        myPageDesignStackView.customStackView(spacing: 5, axis: .horizontal, alignment: .center)
        myPageDesignStackView.distribution = .equalSpacing
        return myPageDesignStackView
    }()
    
    lazy var verLabel: UILabel = {
        let verLabel = UILabel()
        verLabel.text = "ver x.x.x"
        verLabel.textColor = .lightGray
        verLabel.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .bold)
        verLabel.textAlignment = .center
        return verLabel
    }()
    
    lazy var personalRegulations: UILabel = {
        let personalRegulations = UILabel()
        personalRegulations.text = "개인정보처리방침"
        personalRegulations.textColor = .lightGray
        personalRegulations.font = UIFont.spoqaHanSansNeo(size: Constants.fontSize10, weight: .bold)
        personalRegulations.textAlignment = .center
        personalRegulations.isUserInteractionEnabled = true
        return personalRegulations
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            verLabel.text = "Ver \(version)"
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(myPageDesignStackView)
        self.addSubview(verLabel)
        self.addSubview(personalRegulations)
        
        myPageDesignStackView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self.snp.leading).offset(UIScreen.main.bounds.width * 0.3)
            make.trailing.equalTo(self.snp.trailing).offset(-UIScreen.main.bounds.width * 0.3)
        }
        
        verLabel.snp.makeConstraints { make in
            make.top.equalTo(myPageDesignStackView.snp.bottom).offset(7)
            make.leading.equalTo(self.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.horizontalMargin)
        }
        
        personalRegulations.snp.makeConstraints { make in
            make.top.equalTo(verLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self.snp.trailing).offset(-Constants.horizontalMargin)
        }
    }
}
