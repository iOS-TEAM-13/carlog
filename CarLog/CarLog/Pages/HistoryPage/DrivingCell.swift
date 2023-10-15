//
//  DrivingCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import UIKit

class DrivingCell: UITableViewCell {
    
    static let identifier = "DrivingCell"
    
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = Constants.fontJua14 ?? UIFont()
        return writeDateLabel
    }()
    
    lazy var cellBottomLabelStackView: UIStackView = {
        let cellBottomLabelStackView = UIStackView(arrangedSubviews: [driveDistenceLabel, departDistenceLabel])
        cellBottomLabelStackView.axis = .horizontal
        cellBottomLabelStackView.distribution = .equalSpacing
        cellBottomLabelStackView.alignment = .center
        return cellBottomLabelStackView
    }()
    
    lazy var driveDistenceLabel: UILabel = {
        let driveDistenceLabel = UILabel()
        driveDistenceLabel.textColor = .black
        driveDistenceLabel.font = Constants.fontJua28 ?? UIFont()
        return driveDistenceLabel
    }()
    
    lazy var departDistenceLabel: UILabel = {
        let departDistenceLabel = UILabel()
        departDistenceLabel.textColor = .black
        departDistenceLabel.font = Constants.fontJua20 ?? UIFont()
        return departDistenceLabel
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(cellLabelStackView)
        
        cellLabelStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
    }

}
