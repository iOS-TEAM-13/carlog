import UIKit

import SnapKit

class DetailTopTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "달려라 달려라~"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var userNameLabel: UIButton = {
        let button = UIButton()
        button.setTitle("왕바우", for: .normal) // "게시"라는 텍스트 설정
        button.setTitleColor(.black, for: .normal) // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium) // 폰트와 크기 설정
        button.backgroundColor = .clear // 버튼의 배경색 설정
        
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.02"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, UIView(), dateLabel])
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .center)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .yellow
        addSubview(titleLabel)
        addSubview(stackView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(stackView).offset(-Constants.horizontalMargin * 2)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.verticalMargin)
            make.leading.equalTo(self).offset(Constants.horizontalMargin)
            make.trailing.equalTo(self).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(self).offset(-Constants.verticalMargin)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
