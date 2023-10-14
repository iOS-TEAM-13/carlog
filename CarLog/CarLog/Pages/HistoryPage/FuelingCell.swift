//
//  FuelingCell.swift
//  CarLog
//
//  Created by 김지훈 on 2023/10/12.
//

import SnapKit
import UIKit

class FuelingCell: UITableViewCell {
    
    static let identifier = "FuelingCell"
    
    lazy var cellLabelStackView: UIStackView = {
        let cellLabelStackView = UIStackView(arrangedSubviews: [cellTopLabelStackView, cellBottomLabelStackView])
        cellLabelStackView.axis = .vertical
        cellLabelStackView.distribution = .equalSpacing
        return cellLabelStackView
    }()
    
    lazy var cellTopLabelStackView: UIStackView = {
        let cellTopLabelStackView = UIStackView(arrangedSubviews: [writeDateLabel, priceLabel])
        cellTopLabelStackView.axis = .horizontal
        cellTopLabelStackView.distribution = .equalSpacing
        cellTopLabelStackView.alignment = .center
        return cellTopLabelStackView
    }()
    
    lazy var writeDateLabel: UILabel = {
        let writeDateLabel = UILabel()
        writeDateLabel.textColor = .darkGray
        writeDateLabel.font = Constants.fontJua14 ?? UIFont()
        return writeDateLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .black
        priceLabel.font = Constants.fontJua20 ?? UIFont()
        return priceLabel
    }()
    
    lazy var cellBottomLabelStackView: UIStackView = {
        let cellBottomLabelStackView = UIStackView(arrangedSubviews: [totalPriceLabel, countLabel])
        cellBottomLabelStackView.axis = .horizontal
        cellBottomLabelStackView.distribution = .equalSpacing
        cellBottomLabelStackView.alignment = .center
        return cellBottomLabelStackView
    }()
    
    lazy var totalPriceLabel: UILabel = {
        let totalPriceLabel = UILabel()
        totalPriceLabel.textColor = .black
        totalPriceLabel.font = Constants.fontJua28 ?? UIFont()
        return totalPriceLabel
    }()
    
    lazy var countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.textColor = .black
        countLabel.font = Constants.fontJua20 ?? UIFont()
        return countLabel
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
